import * as _ from "lodash";
import { UseFormSetError } from "react-hook-form";
import { KeyboardEvent } from "react";

export const dateTimeLocalFormat = "yyyy-MM-dd'T'HH:mm";
export const emailPattern = /[\w+-]+@[\w+-]+\.[\w+-]+/;

type ApiError = {
  errors?: { message: any; name: string }[];
};

export function handleAPIFormError<T>(
  error: ApiError,
  setError: UseFormSetError<any>
) {
  if (error.errors) {
    _.each(error.errors, (message: any, name: string) =>
      setError(name, { type: "custom", message })
    );
  } else {
    throw error;
  }
}

export function after(sleep: number): Promise<void> {
  return new Promise((resolve) => {
    setTimeout(resolve, sleep);
  });
}

export function onEnterKeyDown(run: { (event: KeyboardEvent): void }): {
  (event: KeyboardEvent): void;
} {
  return (event: KeyboardEvent): void => {
    if (event.key === "Enter") {
      run(event);
    }
  };
}
