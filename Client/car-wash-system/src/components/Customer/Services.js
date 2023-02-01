import React, { useEffect, useState } from "react";
import { makeStyles } from "@material-ui/core/styles";
import Card from "@material-ui/core/Card";
import CardContent from "@material-ui/core/CardContent";
import Typography from "@material-ui/core/Typography";
import "./CSS/Services.css";
import CardMedia from '@mui/material/CardMedia';
import Package from "../../services/member/package/package_services";
import { Grid } from "@material-ui/core";

const useStyles = makeStyles({
  title: {
    fontSize: 14,
  },
  pos: {
    marginBottom: 12,
  },
});

export default function Services(props) {
  const { match, history } = props;
  const { params } = match;
  const { car } = params;
  const classes = useStyles();

  const [services, setServices] = useState([]);

  useEffect(() => {
    Package.getAllServicesForCustomer()
      .then((response) => {
        setServices(response);
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);

  const getServiceCards = (res) => {
    var type,
      where = "";
    if (res.serviceType == 1) {
      type = "Mechanical Services";
    } else if (res.serviceType == 2) {
      type = "Electrical Services";
    } else if (res.serviceType == 3) {
      type = "Wheel Allignment Services";
    }else if (res.serviceType == 4) {
      type = "Car Wash";
    }else if (res.serviceType == 5) {
      type = "Roadside Assistance";
    }else if (res.serviceType == 6) {
      type = "Vehicle Detailing Services";
    }

    if (res.where == 1) {
      where = "Free Pickup & Drop";
    } else {
      where = "Service @ Doorstep";
    }
    return (
      <Grid item xs={12} sm={12} md={6} lg={6} key={res._id}>
        <Card
          className="service_card"
          variant="outlined"
          onClick={() =>
            history.push(`/cust_home/order/car/${car}/service/${res._id}`)
          }
        >
          <CardMedia
        sx={{ height: 140 }}
        image= "https://media.istockphoto.com/id/1315800156/photo/automobile-mechanic-repairman-hands-repairing-a-car-engine-automotive-workshop-with-a-wrench.jpg?b=1&s=170667a&w=0&k=20&c=1mTACjOQsCywELazdevG3b9137Lfzh4ejXMFGMBBUi0="
        title="service provider"
      />
          <CardContent>
            <Typography
              className={classes.title}
              color="textSecondary"
              gutterBottom
            >
              {type}
            </Typography>
            <Typography variant="h5" component="h2">
              {res.name}
            </Typography>
            <Typography component="h6">{res.price}</Typography>
            <Typography variant="body2" component="p">
              {res.description}
            </Typography>
            <Typography
              className={classes.title}
              color="textSecondary"
              gutterBottom
            >
              {where}
            </Typography>
            <hr></hr>
            <div className="action_buttons">
              <span className="timeline">
                {`service done in ${res.timeRequired}`}
              </span>
              <button className="buy_button">Buy</button>
            </div>
          </CardContent>
        </Card>
      </Grid>
    );
  };

  return (
    <div className="container">
      <button onClick={() => history.push(`/cust_home`)}>Change Car</button>
      <hr />
      {services ? (
        <Grid container spacing={5} className="grid_container">
          {services.map((res) => getServiceCards(res))}
        </Grid>
      ) : <h1>No Services Listed</h1>}
    </div>
  );
}
