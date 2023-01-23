import { FieldErrors } from "react-hook-form";

export default function FormError({
  errors,
  name,
}: {
  errors: FieldErrors;
  name: string;
}) {
  const error = errors[name];
  if (!error) return null;

  return (
    <p className="text-rose-500">
      {error.message ? error.message.toString() : error.type?.toString()}
    </p>
  );
}
