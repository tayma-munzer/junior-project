import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
function Services() {
  const [services, setServices] = useState([]);

  useEffect(() => {
    axios
      .get('http://127.0.0.1:8000/api/admin/get_service_requests')
      .then(res => {
        console.log(res.data);
        const servicesArray = Object.values(res.data.services); // Convert object to array
        if (servicesArray.length > 0) {
          setServices(servicesArray);
        } else {
          console.error('Invalid API response format');
        }
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  const deleteService = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم الرفض";
    axios
      .post(`http://127.0.0.1:8000/api/admin/reject_service/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedServices = services.filter(service => service.s_id !== id);
        setServices(updatedServices);
      })
      .catch(function (error) {
        if (error.response) {
          if (error.response.status === 404) {
            alert(error.response.data.message);
            thisClicked.innerText = "رفض";
          }
          if (error.response.status === 500) {
            alert(error.response.data);
          }
        }
      });
  };

  const acceptService = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم القبول";
    axios
      .post(`http://127.0.0.1:8000/api/admin/accept_service/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedServices = services.filter(service => service.s_id !== id);
        setServices(updatedServices);
      })
      .catch(function (error) {
        if (error.response) {
          if (error.response.status === 404) {
            alert(error.response.data.message);
            thisClicked.innerText = "قبول";
          }
          if (error.response.status === 500) {
            alert(error.response.data);
          }
        }
      });
  };

  return (
    <div className="services-container">
      {services.map(service => (
        <div className="card-services" key={service.s_id}>
             <img className="service-image" src={`data:image/jpeg;base64,${service.image}`} alt="Service" />
          <div className="card-content">
            <h2 className="service-title">{service.s_name}</h2>
            <p className="service-description">{service.s_desc}</p>
            <div className="service-details">
              <p>{service.s_duration}</p>
            </div>
            <div className="button-container">
            <button type="button" onClick={(e) => acceptService(e, service.s_id)} className="accept-button">
              قبول
            </button>
            <button type="button" onClick={(e) => deleteService(e, service.s_id)} className="delete-button">
              رفض
            </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

export default Services;