import { selectCurrentUser } from "../../../selectors";
import { useState } from "react";
import { useForm } from "react-hook-form";
import UserChip from "../../UserChip";
import TextareaAutosize from "react-textarea-autosize";
import ToolTip from "../../ToolTip";
import * as _ from "lodash";
import FileAttachClickZone from "../../FileAttachClickZone";
import Button from "../../Button";
import { Photo } from "../../Icons";

export type PostData = {
  body: string;
  images: File[];
};

export default function Form({
  placeholder,
  onSubmit,
  submitText,
  focus = false,
}: {
  placeholder: string;
  onSubmit: { (data: PostData): Promise<void> };
  submitText: string;
  focus?: boolean;
}) {
  const user = selectCurrentUser();
  const [focused, setFocused] = useState(focus);

  const {
    register,
    handleSubmit,
    watch,
    reset,
    setValue,
    formState: { isSubmitting },
  } = useForm<PostData>({
    defaultValues: { body: "", images: [] },
  });

  const images = watch("images");

  async function onSubmitClick(data: PostData) {
    await onSubmit(data);

    reset();
    setFocused(false);
  }

  return (
    <div className="flex flex-col space-y-3">
      {focused && user && <UserChip user={user} />}

      <TextareaAutosize
        {...register("body", { required: true })}
        disabled={isSubmitting}
        autoFocus={focus}
        minRows={focused ? 2 : 1}
        onFocus={() => setFocused(true)}
        className="input w-full"
        placeholder={placeholder}
      />

      {images.length > 0 && (
        <div className="flex flex-row flex-wrap gap-3">
          {images.map((image: File, index) => (
            <ToolTip
              key={image.name}
              disabled={isSubmitting}
              tooltip={
                <p
                  className="link"
                  onClick={() => setValue("images", _.without(images, image))}
                >
                  Remove image
                </p>
              }
            >
              <img
                src={URL.createObjectURL(image)}
                alt={`image #${index}`}
                className="object-fit h-44 w-auto"
              />
            </ToolTip>
          ))}
        </div>
      )}

      {focused && (
        <div className="flex flex-row justify-end space-x-3">
          <FileAttachClickZone
            onFiles={(files) => setValue("images", images.concat(files))}
            multiple={true}
          >
            <Button disabled={isSubmitting}>
              <Photo />
            </Button>
          </FileAttachClickZone>

          <Button
            primary={true}
            loading={isSubmitting}
            onClick={handleSubmit(onSubmitClick)}
          >
            {submitText}
          </Button>
        </div>
      )}
    </div>
  );
}
