import { useForm } from "react-hook-form";
import { useAppDispatch, useToast } from "../../hooks";
import { createSession } from "../../store/userSlice";
import FormLabelWithError from "../FormLabelWithError";
import { emailPattern, handleAPIFormError, onEnterKeyDown } from "../../util";
import { Link } from "react-router-dom";
import Button from "../Button";
import { useState } from "react";

type FormData = {
  email: string;
};

export default function LogIn() {
  const dispatch = useAppDispatch();
  const toast = useToast();
  const {
    register,
    handleSubmit,
    reset,
    setError,
    watch,
    formState: { isSubmitting, errors },
  } = useForm<FormData>({ defaultValues: { email: "" } });

  const email = watch("email");
  const [oauthProviders, setOauthProviders] = useState([]);

  // useEffect(() => {
  //   fetch("/oauth2/providers")
  //     .then((response) => response.json())
  //     .then((json) => setOauthProviders(json));
  // }, []);

  async function onSubmit({ email }: FormData) {
    try {
      await dispatch(createSession({ email })).unwrap();
      toast("Email sent").catch(console.error);
      reset();
    } catch (error: any) {
      handleAPIFormError(error, setError);
    }
  }

  return (
    <div className="container mx-auto max-w-xs space-y-5 px-3 md:px-0">
      <p className="text-xl font-bold">Log In</p>

      <div className="flex w-full flex-col space-y-1">
        <FormLabelWithError errors={errors} label="Email" name="email" />

        <input
          {...register("email", { required: true, pattern: emailPattern })}
          className="input"
          disabled={isSubmitting}
          placeholder="you@example.com"
          autoFocus={!email}
          onKeyDown={onEnterKeyDown(handleSubmit(onSubmit))}
        />
      </div>

      <div className="flex flex-row items-center justify-between space-x-3">
        <Link to="/signup" className="link">
          Sign Up
        </Link>

        <Button
          primary={true}
          loading={isSubmitting}
          onClick={handleSubmit(onSubmit)}
        >
          Log In
        </Button>
      </div>

      <div>
        {oauthProviders.map((oauthProvider) => (
          <div key={oauthProvider}>
            <a href={`/oauth2/${oauthProvider}/login`} className="btn">
              <Button>
                Sign in with <span className="capitalize">{oauthProvider}</span>
              </Button>
            </a>
          </div>
        ))}
      </div>
    </div>
  );
}
