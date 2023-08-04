import { useForm } from "react-hook-form";
import { useAppDispatch, useToast } from "../../hooks";
import { createUser } from "../../store/userSlice";
import FormLabelWithError from "../FormLabelWithError";
import { emailPattern, handleAPIFormError, onEnterKeyDown } from "../../util";
import { Link } from "react-router-dom";
import Button from "../Button";

type FormData = {
  email: string;
  username: string;
};

export default function SignUp() {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const {
    register,
    handleSubmit,
    reset,
    setError,
    watch,
    formState: { isValid, isSubmitting, errors },
  } = useForm<FormData>({ defaultValues: { email: "", username: "" } });

  const email = watch("email");
  const username = watch("username");

  async function onSubmit(data: FormData) {
    try {
      await dispatch(
        createUser({ username: data.username, email: data.email })
      ).unwrap();

      toast("Email sent").catch(console.error);
      reset();
    } catch (error: any) {
      handleAPIFormError(error, setError);
    }
  }

  return (
    <div className="container mx-auto max-w-xs space-y-5 px-3 md:px-0">
      <p className="text-xl font-bold">Create an Account</p>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="Email" name="email" />

        <input
          {...register("email", { required: true, pattern: emailPattern })}
          disabled={isSubmitting}
          className="input"
          placeholder="you@example.com"
          autoFocus={!email}
          onKeyDown={onEnterKeyDown(handleSubmit(onSubmit))}
        />
      </div>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="Username" name="username" />

        <input
          {...register("username", { required: true, minLength: 8 })}
          disabled={isSubmitting}
          className="input"
          placeholder="snowboarderX23"
          autoFocus={!username}
          onKeyDown={onEnterKeyDown(handleSubmit(onSubmit))}
        />
      </div>

      <div className="flex flex-row items-center justify-between space-x-3">
        <Link to="/login" className="link">
          Log In
        </Link>

        <Button
          primary={true}
          disabled={!isValid}
          loading={isSubmitting}
          onClick={handleSubmit(onSubmit)}
        >
          Sign Up
        </Button>
      </div>
    </div>
  );
}
