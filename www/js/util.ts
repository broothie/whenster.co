import { UseFormSetError } from "react-hook-form";
import { KeyboardEvent } from "react";
import { DateTime } from "luxon";

export const dateTimeLocalFormat = "yyyy-MM-dd'T'HH:mm";
export const emailPattern = /[\w+-]+@[\w+-]+\.[\w+-]+/;

type ApiError = {
  errors: { message: any; name: string }[];
};

export function handleAPIFormError<T>(
  error: ApiError,
  setError: UseFormSetError<any>
) {
  if (error.errors) {
    error.errors.forEach(({ name, message }) =>
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
  if (DateTime.isDateTime(data)) return { "": (data as DateTime).toISO() };
  if (typeof data !== "object") return { "": data }; // Primitives / catch-all
  if (typeof data?.name === "string") return { "": data }; // File or Blob

  const result = {} as { [key: string]: any };
  for (const index in data) {
    const indexString = Array.isArray(data) ? "" : index.toString();
    const prefix = _isTop ? indexString : `[${indexString}]`;

    const subResult = parameterizeData(data[index], false);
    for (const key in subResult) {
      result[`${prefix}${key}`] = subResult[key];
    }
  }

  return result;
}
