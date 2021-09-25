import React, { useState } from "react";
import axios from "axios";
import { toast } from "react-toastify";
import { Button } from "@material-ui/core";
import { Dialog } from "@material-ui/core";
import { DialogContent } from "@material-ui/core";
import { DialogActions } from "@material-ui/core";
import { DialogContentText } from "@material-ui/core";
import { DialogTitle } from "@material-ui/core";
import { useHistory, useLocation } from "react-router";
import "./css/futureAlert.css";

const FutureUpgradeAlert = () => {
  const [open, setOpen] = React.useState(true);
  const history = useHistory();

  const handleClose = () => {
    history.push({
      pathname: "/courses",
    });
  };
  return (
    <div className="future-background">
      <Dialog
        open={open}
        onClose={handleClose}
        aria-labelledby="alert-dialog-title"
        aria-describedby="alert-dialog-description"
        className="future-background"
      >
        <DialogTitle id="alert-dialog-title">{"Remember !"}</DialogTitle>
        <DialogContent>
          <DialogContentText id="alert-dialog-description">
            Selected assessment tool is marked as conducted. The feature to
            grade students is in progress
          </DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose} className="future-button">
            Okay
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
};

export default FutureUpgradeAlert;
