import {
  Fragment,
  useEffect,
  useMemo,
  useState,
  useRef,
  useCallback,
  useLayoutEffect,
} from "react";
import type { FC } from "react";
import cn from "classnames";

export type Props = {};

export const ComponentFC: FC<Props> = (props) => {
  const [value, setValue] = useState<Boolean>(false);

  return useMemo(() => {
    return (
      <Fragment>
        <div>Hello React</div>
      </Fragment>
    );
  }, [value]);
};

export default ComponentFC;
