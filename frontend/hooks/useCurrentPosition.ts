import { useCallback, useEffect, useState } from 'react';

export function useCurrentPosition() {
  const [position, setPosition] = useState();

  const handlePositionChange = useCallback(({ coords }: Position) => {
    const { latitude, longitude } = coords;
    setPosition({ latitude, longitude });
  },                                       []);

  useEffect(() => {
    if (process.browser && navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(handlePositionChange);
    }

    return position;
  },        []);

  return position;
}
