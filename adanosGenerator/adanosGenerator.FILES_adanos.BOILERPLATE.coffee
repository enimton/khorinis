adanosGenerator.FILES['adanos.BOILERPLATE.coffee'] = '''
  adanos.BOILERPLATE =

    PAGE_HTML: """
      <head>
        <meta charset="utf-8">
        <title>New Khorinis Project</title>
      </head>

      <body class="page">
        <div class="page__container">
          <h1 class="page__title">
            Khorinis is ready.<br>
            Let's write great things!
          </h1>

          <ul class="page__instructions">
            <li>
              Exclude
              {{> page__highlight '_blocks'}} and
              {{> page__highlight 'packages/khorinis-adanos'}}
              directories from your code editor
            </li>
            <li>
              Write application in {{> page__highlight 'private/blocks'}} directory
            </li>
          </ul>
        </div>
      </body>

      <template name="page__highlight" this="text">
        <span class="page__highlight">{{this}}</span>
      </template>

      """

    PAGE_CSS: """
      .page {
        font-family: sans-serif;

        color: #333;
        background: #fff;
      }

      .page__container {
        width: 650px;
        margin: 200px auto 0;
      }

      .page__title {
        font-size: 40px;
      }

      .page__instructions {
        line-height: 25px;

        padding-left: 20px;
      }

      .page__highlight {
        font-family: monospace;
        font-size: 14px;

        padding: 2px 5px;

        border-radius: 2px;
        background: #eaefe9;
      }


      """

    DEBUGGER_JS: """
      k('debugger'
      , ''
      , function(blocks) {
        window.blocks = blocks;
      });

      """

    ADANOS_CONFIG: """
      {
        "delimiters": {
          "elem": "__",
          "mod": "--"
        }
      }

      """

  '''
