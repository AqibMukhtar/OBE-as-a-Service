import React from "react";
import { Button } from "@material-ui/core";
import { Dialog } from "@material-ui/core";
import { DialogContent } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import { DialogContentText } from "@material-ui/core";
import { DialogTitle } from "@material-ui/core";
import { useHistory } from "react-router";

const FutureUpgradeAlert = () => {
  const [open, setOpen] = React.useState(true);
  const history = useHistory();

  const handleClose = () => {
    history.push({
      pathname: "/courses",
    });
  };
  return (
    <div>
      <Dialog
        open={open}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
      >
        <DialogTitle id="alert-dialog-title">
          {"Use Google's location service?"}
        </DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Let Google help apps determine location. This means sending
            anonymous location data to Google, even when no apps are running.
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>Disagree</Button>
          <Button onClick={handleClose} autoFocus>
            Agree
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default FutureUpgradeAlert;
