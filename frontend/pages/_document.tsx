import React from 'react';
import Document, { Head, Main, NextScript, NextDocumentContext, AnyPageProps } from 'next/document';
import flush from 'styled-jsx/server';
import { PageContext } from '../theme/context';

interface Props {
  pageContext: PageContext;
}

interface PageProps extends AnyPageProps {
  pageContext: PageContext;
}

class NextDocument extends Document<Props> {
  static getInitialProps = (ctx: NextDocumentContext) => {
    let pageContext: PageContext;

    const page = ctx.renderPage(Component => {
      return (props: PageProps) => {
        pageContext = props.pageContext;
        return <Component {...props} />;
      };
    });

    const css = pageContext ? pageContext.sheetsRegistry.toString() : null;

    return {
      ...page,
      pageContext,
      styles: (
        <>
          <style
            id="jss-server-side"
            dangerouslySetInnerHTML={{
              __html: css,
            }}
          />
          {flush() || null}
        </>
      ),
    };
  };

  render() {
    const { pageContext } = this.props;

    return (
      <html lang="pt-br" dir="ltr">
        <Head>
          <meta
            name="viewport"
            content="minimum-scale=1, initial-scale=1, width=device-width, shrink-to-fit=no"
          />
          <meta
            name="theme-color"
            content={pageContext ? pageContext.theme.palette.primary.main : null}
          />
          <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css?family=Roboto:300,400,500"
          />
        </Head>
        <body>
          <Main />
          <NextScript />
        </body>
      </html>
    );
  }
}

export default NextDocument;
