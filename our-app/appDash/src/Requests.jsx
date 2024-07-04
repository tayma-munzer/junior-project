import React from 'react';
import {Link} from 'react-router-dom';
function Requests() {
  return (
    <div  className="requests-container">
      <Link to='/Services' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>SERVICES</h3>
          <p>View Services Requests</p>
        </div>
      </Link>
      <Link to='/Jobs' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>JOBS</h3>
          <p>View Jobs Requests</p>
        </div>
      </Link>
      <Link to='/Courses' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>COURSES</h3>
          <p>View Courses Requests</p>
        </div>
      </Link>
    </div>
  );
}

export default Requests;