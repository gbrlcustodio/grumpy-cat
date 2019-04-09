import { SheetsRegistry } from 'react-jss';
import { createMuiTheme, createGenerateClassName } from '@material-ui/core/styles';

const theme = createMuiTheme({
  typography: {
    useNextVariants: true,
  },
});

function createPageContext() {
  return {
    theme,
    // This is needed in order to deduplicate the injection of CSS in the page.
    sheetsManager: new Map(),
    // This is needed in order to inject the critical CSS.
    sheetsRegistry: new SheetsRegistry(),
    // The standard class name generator.
    generateClassName: createGenerateClassName(),
  };
}

export type PageContext = ReturnType<typeof createPageContext>;

let pageContext: PageContext;

export function getPageContext() {
  // Make sure to create a new context for every server-side request so that data
  // isn't shared between connections.
  if (typeof window === 'undefined') {
    return createPageContext();
  }

  // Reuse context on client-side.
  if (!pageContext) {
    pageContext = createPageContext();
  }

  return pageContext;
}
