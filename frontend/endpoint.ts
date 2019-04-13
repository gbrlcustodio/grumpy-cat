const endpoint = 'http://localhost:4000/api';

function generateHeaders(method: 'GET' | 'POST', body?: string): RequestInit {
  return {
    method,
    body,
    mode: 'cors',
    cache: 'default',
    headers: {
      'Content-Type': 'application/json',
      Accept: 'application/json',
    },
  };
}

export function get(path: string) {
  return fetch(endpoint + path, generateHeaders('GET')).then(response => response.json());
}

export function post(path: string, params: any) {
  return fetch(endpoint + path, generateHeaders('POST', JSON.stringify(params))).then(response =>
    response.json(),
  );
}
