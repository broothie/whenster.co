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

export function formDataFrom(data: any, _isTop = true): FormData {
  const formData = new FormData();
  const result = parameterizeData(data);
  for (const key in result) {
    formData.append(key, result[key]);
  }

  return formData;
}

export function parameterizeData(
  data: any,
  _isTop = true
): { [key: string]: any } {
  if (typeof data !== "object") return { "": data }; // Primitives / catch-all
  if (typeof data.name === "string") return { "": data }; // File or Blob

  const result = {} as { [key: string]: any };
  for (const index in data) {
    const prefix = _isTop ? index : `[${index}]`;

    const subResult = parameterizeData(data[index], false);
    for (const key in subResult) {
      result[`${prefix}${key}`] = subResult[key];
    }
  }

  return result;
}
