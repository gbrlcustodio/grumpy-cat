import { useCallback, useState } from 'react';

export function useCurrentPosition() {
  const [position, setPosition] = useState();
  const handlePositionChange = useCallback(() => {}, [position]);

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(handlePositionChange);
  }

  return position;
}
