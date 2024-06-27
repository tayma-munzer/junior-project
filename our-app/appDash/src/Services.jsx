import React from 'react';

function Services() {
  // Sample data for services
  const services = [
    {
      id: 1,
      title: 'العنوان 1',
      description: 'التوصيف 1',
      price: 'السعر 1',
      buyers: 'عدد المشترين 1',
      duration: 'مدة التسليم 1',
    },
    {
      id: 2,
      title: 'العنوان 2',
      description: 'التوصيف 2',
      price: 'السعر 2',
      buyers: 'عدد المشترين 2',
      duration: 'مدة التسليم 2',
    },
    // Add more services here
  ];

  return (
    <div className="services-container">
      {services.map((service) => (
        <div className="card-services" key={service.id}>
          <img className="service-image" src="path/to/s_img.jpg" alt="Service" />
          <div className="card-content">
            <h2 className="service-title">{service.title}</h2>
            <p className="service-description">{service.description}</p>
            <div className="service-details">
              <p>{service.price}</p>
              <p>{service.buyers}</p>
              <p>{service.duration}</p>
            </div>
            <div className="button-container">
              <button className="accept-button">رفض</button>
              <button className="delete-button">قبول</button>
            </div>
          </div>
          
        </div>
      ))}
    </div>
  );
}

export default Services;