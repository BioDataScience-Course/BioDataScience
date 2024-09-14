# RStudio addins

sdd_help_addin <- function()
  .sdd_help_addin() # See here under

sdd_repo_issue_addin <- function()
  sdd_repo_issue()

disk_info_addin <- function()
  disk_info()

sdd_info_addin <- function()
  sdd_info()

sdd_user_addin <- function()
  (sign_in())

#sign_out_addin <- function()
#  sign_out()

switch_repo_addin <- function()
  invisible(switch_repo())


#' Get help for the BioDataScience course
#'
#' This fonction uses a Shiny gadget and RStudio context. It is only available
#' from the addins menu in RStudio.
#'
#' @return The corresponding R code for the command that is invoked is returned
#'   invisibly as a noquote object.
#' @importFrom shiny actionButton br code conditionalPanel dialogViewer em h4 icon observeEvent p plotOutput renderPlot selectInput sliderInput stopApp strong textInput runGadget
#' @importFrom miniUI gadgetTitleBar miniButtonBlock miniContentPanel miniPage miniTabPanel miniTabstripPanel  miniTitleBarButton miniTitleBarCancelButton
#' @importFrom shinyAce aceEditor
#' @importFrom methods findFunction
#' @importFrom svMisc assign_temp get_temp
#' @importFrom rstudioapi sendToConsole
#' @importFrom utils ? methods
.sdd_help_addin <- function() {

  get_help <- function(message) {

    # Possible help engines
    engines <- c("Help pages", "SciViews Chatbot", "Rseek", "StackOverflow",
      "Google", "Bing", "DuckDuckGo")

    # Get the context:
    # - current selection, or word under the cursor in an editor
    # - if cur_sel looks like a function name -> define cur_fun
    # - last error message
    # - last warning message
    # - last message is error if present, otherwise, it is warning
    cur_sel <- .get_word_or_selection()
    if (is.null(cur_sel) || !length(cur_sel))
      cur_sel <- ""
    # Default empty message for functions
    alt_fun_msg <- em(
      "Select the name of a function in an editor",
      "before calling this addin if you want help on it..."
    )

    # Only look for a function if selection is short
    if (nchar(cur_sel) < 120) {
      #If cur_sel is something like ns::fun, we already know ns
      if (grepl("::", cur_sel)) {
        fun <- sub("^([^:]+)(::)([^(]+)(.*)$", "\\3", cur_sel)
        ns <- sub("^([^:]+)(::)([^(]+)(.*)$", "\\1", cur_sel)
        # If fun contains $, like in tabularise$headtail, we search for
        # tabularise::tabularise_headtail -> replace $ by _
        orig_fun <- fun
        fun <- sub("$", "_", fun, fixed = TRUE)
        if (orig_fun != fun) {# fun$type -> fun_type -> check it exists
          if (!length(methods::findFunction(fun))) {
            # function not found, truncate fun before $
            fun <- orig_fun <- sub("^([^$]+)\\$.+$", "\\1", orig_fun)
          }
        }
        alt_fun_msg <- ""
      } else {# Find the function and its namespace
        if (grepl("(", cur_sel, fixed = TRUE)) {
          cur_fun <- sub("^([^(]+)(.*)$", "\\1", cur_sel)
        } else {
          cur_fun <- sub("^([.a-zA-Z0-9_$]+)(.*)$", "\\1", cur_sel)
        }
        if (cur_fun == "") {
          fun_env_names <- character(0) # Nothing
        } else {
          # If fun contains $, like in tabularise$headtail, we search for
          # tabularise_headtail -> replace $ by _
          orig_fun <- cur_fun
          cur_fun <- sub("$", "_", cur_fun, fixed = TRUE)
          fun_envs <- methods::findFunction(cur_fun)
          # If not found and orig_fun != cur_fun, truncate cur_fun before $
          if (!length(fun_envs) && orig_fun != cur_fun) {
            cur_fun <- orig_fun <- sub("^([^$]+)\\$.+$", "\\1", orig_fun)
            fun_envs <- methods::findFunction(cur_fun)
          }
          fun_env_names <- unique(sapply(fun_envs, environmentName))
          # Replace "package:<name>" by "<name>"
          fun_env_names <- sub("^([^:]+:)(.+)$", "\\2", fun_env_names)
          # If the function is in GlobalEnv, it appears last, but put it first
          if ("R_GlobalEnv" %in% fun_env_names) {
            # Also transform R_GlobalEnv into ""
            fun_env_names <- c("",
              fun_env_names[fun_env_names != "R_GlobalEnv"])
          }
        }
        l <- length(fun_env_names)
        if (!l) {# Function not found
          # Ask help system directly
          cmd <- parse(text = paste0("?", cur_fun))
          if (length(eval(cmd))) {# Help page found
            fun <- cur_fun
            ns <- "" # Unknown
            alt_fun_msg <- ""
          } else {# Not found
            fun <- ""
            ns <- ""
          }
        } else if (l == 1) { # || (l == 2 &&
          # Only one function with this name found
          fun <- cur_fun
          ns <- fun_env_names[1]
          alt_fun_msg <- ""
        } else {# Several functions with the same name
          fun <- cur_fun
          ns <- fun_env_names[1]
          # create an alt_fun_msg
          if (l == 2) {
            alt_fun_msg <- em(
              "Another function with the same name is found.\n\n",
              "To use it, you should specify its namespace (",
              code(paste(fun_env_names[2], fun, sep = "::")), ")")
          } else {
            alt_fun_msg <- em(
              "Several functions with the same name are found.\n\n",
              "To use one of them, you should specify its namespace (",
              code(paste(fun_env_names[-1], fun, sep = "::", collapse = ", ")),
              ")"
            )
          }
        }
      }
    } else {# No function?
      fun <- ""
      ns <- ""
    }
    if (fun != "") {
      # If the function is generic, propose to select a method
      # Note: if the function does not appear to be an S3 generic, methods() still
      # returns functions that look like methods with a warning. We want an error
      # instead, so, we temporarilly transform warining into errors.
      owarn <- getOption("warn")
      options(warn = 2)
      if (ns != "") {
        full_fun <- paste(ns, fun, sep = "::")
        meths <- try(eval(parse(text = paste0("methods(", full_fun, ")"))),
          silent = TRUE)
      } else {
        full_fun <- fun
        meths <- try(methods(fun), silent = TRUE)
      }
      options(warn = owarn)
      if (inherits(meths, "try-error")) meths <- character(0)
      meths <- as.character(meths)
      if (!length(meths)) {
        meths <- ""
      } else {
        # Put fun (generic) as first item in meths, if there are methods
        #if (length(meths) > 1  || meths != "")
          meths <- c(paste(full_fun, "(generic)"), meths)
      }
    } else {# No function -> no methods
      meths <- ""
      full_fun <- ""
    }


    ui <- miniPage(
      miniTabstripPanel(id = "help_tab",
        miniTabPanel("Function", #icon = icon("cogs"),
          miniContentPanel(
            if (fun == "") {
              h4("No function selected")
            } else {
              h4(paste0(orig_fun, "()"))
            },
            if (ns != "") p("Function from the package", strong(ns)) else
              p(""),
            p(alt_fun_msg),
            if (length(meths) > 1) p("This is a generic function.") else p(""),
            conditionalPanel(condition = "input.method.length > 0",
              selectInput("method", paste0("Select a method:"),
                selectize = FALSE, size = 11, meths)
            )
          )
        ),
        miniTabPanel("Code", #icon = icon("code"),
          miniContentPanel(
            h4("Explain R code (short, less than ten lines advised):"),
            p(em("Not for help pages, better use the chatbot as engine here.")),
            shinyAce::aceEditor("code", mode = "r", theme = "tomorrow",
              height = "80%", fontSize = 12, tabSize = 2, wordWrap = TRUE,
              showInvisibles = TRUE, placeholder = "Type or paste R code here",
              value = cur_sel
            )
          )
        ),
        miniTabPanel("Error/Warning", #icon = icon("bug"),
          miniContentPanel(
            h4("Explain R error/warning (last message automatically added):"),
            p(em("Not for help pages, better use the chatbot as engine here.")),
            shinyAce::aceEditor("error", mode = "plain_text",
              theme = "tomorrow",
              height = "40%", fontSize = 12, tabSize = 2, wordWrap = TRUE,
              showInvisibles = FALSE, showLineNumbers = FALSE, value = message,
              placeholder = "Paste R error or warning message here"
            ),
            p(strong("Line of R code that generated the message (optional):")),
            shinyAce::aceEditor("errorcode", mode = "r", theme = "tomorrow",
              height = "30%", fontSize = 12, tabSize = 2, wordWrap = TRUE,
              showInvisibles = TRUE, value = "",
              placeholder = "Paste the R code that generated the message here"
            )
          )
        ),
        miniTabPanel("Term", #icon = icon("message"),
          miniContentPanel(
            h4("Define or explain a (statistical) term:"),
            textInput("term", label = "", value = "",
              placeholder = "Type or paste a term here")
          )
        ),
        miniTabPanel("Question", #icon = icon("question"),
          miniContentPanel(
            h4("Ask your question (about R, stat or data science):"),
            p(em("Not for help pages, use any of the other engines.")),
            shinyAce::aceEditor("question", mode = "plain_text",
              theme = "tomorrow",
              height = "80%", fontSize = 12, tabSize = 2, wordWrap = TRUE,
              showInvisibles = FALSE, showLineNumbers = FALSE,
              placeholder = "Type or paste you question here", value = ""
            )
          )
        ),

        between = list(
          selectInput("engine", paste0("-  Get Help from (engine):"),
            selected = svMisc::get_temp("sdd_help_engine",
              "Help pages (function or term only)"),
            multiple = FALSE, selectize = FALSE, size = NULL, #width = '90%',
            engines),
          selectInput("lang", paste0("-  Language (for the chatbot only):"),
            selected = svMisc::get_temp("sdd_help_lang", ""),
            multiple = FALSE, selectize = FALSE, size = NULL, #width = '90%',
            list(Automatic = "", English = "en", "Fran\u00e7ais" = "fr"))
        )
      ),

      gadgetTitleBar("",
        left  = miniTitleBarCancelButton(),
        right = miniTitleBarButton("done", "Help Me!", primary = TRUE)
      )
    )

    # Possible help engines (recall)
    #engines <- c("Help pages", "SciViews Chatbot", "Rseek", "StackOverflow",
    #  "Google", "Bing", "DuckDuckGo")

    server <- function(input, output, session) {

      observeEvent(input$cancel, {
        stopApp(NULL)
      })

      observeEvent(input$done, {
        # Save selection of engine and language
        svMisc::assign_temp("sdd_help_engine", input$engine)
        svMisc::assign_temp("sdd_help_lang", input$lang)

        fun_method <- sub("^(.+) \\(generic\\)$", "\\1", input$method)
        if (fun_method == "") fun_method <- full_fun

        context <- switch(input$help_tab,
          "Function"      = list(topic = "fun", question = fun_method,
            info = NULL, engine = input$engine, lang = input$lang),

          "Code"          = list(topic = "code", question = input$code,
            info = NULL, engine = input$engine, lang = input$lang),

          "Error/Warning" = list(topic = "error", question = input$error,
            info = if (input$errorcode == "") NULL else input$errorcode,
            engine = input$engine, lang = input$lang),

          "Term"          = list(topic = "term", question = input$term,
            info = NULL, engine = input$engine, lang = input$lang),

          "Question"     = list(topic = "question", question = input$question,
            info = NULL, engine = input$engine, lang = input$lang),
        )
        stopApp(context)
      })
    }

    runGadget(ui, server,
      viewer = dialogViewer("Get help"))
  }

  error_message <- geterrmessage()
  warning_messages <-  as.list(warnings())
  l <- length(warning_messages)
  if (!l) {
    warning_message <- ""
  } else {# Get last warning (construct a string similar to warning output)
    warning_message <- paste(
      gettext("Warning message:", domain = "R"),
      sprintf(gettext("In %s :", domain = "R"),
        deparse(warning_messages[[l]])),
      names(warning_messages)[l], sep = "\n")
  }
  if (error_message != "") {
    message <- error_message
  } else {
    message <- warning_message
  }

  context <- suppressMessages(get_help(message))
  if (is.null(context) || !length(context) || !is.list(context)) {
    # User cancelled or nothing selected
    return(invisible())
  }

  # Possibly escape "
  esc <- function(x) gsub('"', '\\"', x, fixed = TRUE)

  # Code to run depends on engine:
  help_code <- switch(context$engine,

    `Help pages` = {
      if (context$question == "")
        stop("No function selected")
      if (!context$topic %in% c("fun", "term"))
        stop("Help pages are only for functions or terms")
      if (context$topic == "fun") {
        paste0("?", context$question)
      } else {
        paste0("??", context$question)
      }
    },

    `SciViews Chatbot` = {
      lang_arg <- if (context$lang == "") "" else
        sprintf(", lang = \"%s\"", context$lang)
      code_arg <- if (is.null(context$info)) "" else
        sprintf("code = \"%s\", ", esc(context$info))
      switch(context$topic,
        fun      = sprintf("SciViews::ai_explain_function(\"%s\"%s)",
          context$question, lang_arg),
        code     = sprintf("SciViews::ai_explain_code(\"%s\"%s)",
          esc(context$question), lang_arg),
        error    = sprintf("SciViews::ai_explain_error(%serror = \"%s\"%s)",
          code_arg, esc(context$question), lang_arg),
        term     = sprintf("SciViews::ai_explain_term(\"%s\"%s)",
          esc(context$question), lang_arg),
        question = sprintf("SciViews::ai_ask(\"%s\"%s)",
          esc(context$question), lang_arg)
      )
    },

    # Bug: searcher() fails to encode = and & for the query string!
    Rseek = sprintf(
      "searcher::search_rseek(\"%s\", rlang = %s)", esc(context$question),
      as.character(!context$topic %in% c("term", "question"))),

    StackOverflow = sprintf(
      "searcher::search_stackoverflow(\"%s\", rlang = %s)",
      esc(context$question),
      as.character(!context$topic %in% c("term", "question"))),

    Google = sprintf(
      "searcher::search_google(\"%s\", rlang = %s)", esc(context$question),
      as.character(!context$topic %in% c("term", "question"))),

    Bing = sprintf(
      "searcher::search_bing(\"%s\", rlang = %s)", esc(context$question),
      as.character(!context$topic %in% c("term", "question"))),

    DuckDuckGo = sprintf(
      "searcher::search_duckduckgo(\"%s\", rlang = %s)", esc(context$question),
      as.character(!context$topic %in% c("term", "question"))),
    stop(context$engine, " unknown")
  )

  # Run code now
  #cat("You can also type this code here:\n")
  #message(help_code)
  rstudioapi::sendToConsole(help_code, execute = TRUE, echo = TRUE,
    focus = FALSE)
  invisible(help_code)
}


# atcursor::get_word_or_selection (Miles Mac Brain) -----------------------

# Use of atcursor::get_word_or_selection() from MilesMcBrain, but the code is
# copied here because we do not want to depend on a supplementary package,
# see https://github.com/MilesMcBain/atcursor/tree/main
# (same MIT license as this package)

#' Get word or selection at cursor
#'
#' This function defines a word as a possibly namespaced R symbol. So a cursor
#' on the name of `pkg::var(foo)` will return 'pkg::var'. `$` is considered a
#' separator.
#'
#' If there are any selections the primary selection takes precedence and is
#' returned.
#'
#' @returns a character vector containing the current word at the cursor or
#' primary selection
#' @importFrom rstudioapi getSourceEditorContext primary_selection
.get_word_or_selection <- function() {
  # PhG: this work only in R scripts, but not Rmd files
  # -> getSourceEditorContext instead
  #context <- rstudioapi::getActiveDocumentContext()
  context <- rstudioapi::getSourceEditorContext()
  current_selection <- rstudioapi::primary_selection(context)
  if (!.is_zero_length_selection(current_selection)) {
    return(current_selection$text)
  }
  cursor_line <- .get_cursor_line(context, current_selection)
  cursor_col <- .get_cursor_col(current_selection)
  symbol_locations <- .get_symbol_locations(cursor_line)
  cursor_symbol <-
    symbol_locations[
      symbol_locations$start <= cursor_col &
        symbol_locations$end >= cursor_col,
    ]
  if (nrow(cursor_symbol) == 0) {
    return(character(0))
  }
  substring(cursor_line, cursor_symbol$start, cursor_symbol$end)
}

.is_zero_length_selection <- function(selection) {
  all(selection$range$start == selection$range$end)
}

#' get the line the cursor is on
#'
#' @param context the rtsudioapi document context
#' @param current_selection the selection to find the line for, defaults to
#'   primary selection
.get_cursor_line <- function(
    context,
  current_selection = rstudioapi::primary_selection(context)
) {
  line_num <- current_selection$range$start["row"]
  context$contents[[line_num]]
}

#' get the column the cursor is on from a selection
#'
#' @param current_selection a selection from the rstudioapi document context
.get_cursor_col <- function(current_selection) {
  current_selection$range$start["column"]
}

.get_symbol_locations <- function(code_line) {
  matches <- gregexpr(
    # PhG: changed to include $ as in tabularise$head_tail(...)
    "(?:[A-Za-z]|[.][A-Za-z])[A-Za-z0-9_.\\$]+(?::{2,3}(?:[A-Za-z]|[.][A-Za-z])[A-Za-z0-9_.\\$]+)?",
    code_line,
    perl = TRUE
  )
  match_df <- data.frame(
    start = c(matches[[1]]),
    length = attr(matches[[1]], "match.length")
  )
  match_df$end <- match_df$start + match_df$length - 1
  match_df
}
