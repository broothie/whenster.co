import { useToast } from "../hooks";
import { useState } from "react";
import Button from "./Button";
import ToolTip from "./ToolTip";

export default function Testing() {
  const toast = useToast();
  const [isToasting, setIsToasting] = useState(false);

  async function onToastClick() {
    setIsToasting(true);

    try {
      await toast("yum!", { loader: true });
    } catch (error) {
      console.error(error);
    } finally {
      setIsToasting(false);
    }
  }

  return (
    <div className="container mx-auto flex flex-col items-center">
      <Button onClick={onToastClick} loading={isToasting}>
        Test Toast
      </Button>

      <div className="mb-10"></div>

      <ToolTip tooltip="Lots of words and things">
        <Button>Something</Button>
      </ToolTip>
    </div>
  );
}
