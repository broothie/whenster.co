import { FieldErrors } from "react-hook-form";
import FormError from "./FormError";

export default function FormLabelWithError({
  errors,
  label,
  name,
}: {
  errors: FieldErrors;
  label: string;
  name: string;
}) {
  return (
    <div className="flex flex-row gap-2">
      <label htmlFor={name} className="light">
        {label}
      </label>
      <FormError errors={errors} name={name} />
    </div>
  );
}
