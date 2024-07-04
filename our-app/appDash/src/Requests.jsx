import React from 'react';
import {Link} from 'react-router-dom';
function Requests() {
  return (
    <div  className="requests-container">
      <Link to='/Services' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الخدمات</h3>
          <p>إظهار طلبات الخدمات</p>
        </div>
      </Link>
      <Link to='/Jobs' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الوظائف</h3>
          <p>إظهار طلبات الوظائف</p>
        </div>
      </Link>
      <Link to='/Courses' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الدورات التعليمية</h3>
          <p>إظهار طلبات الدورات التعليمية</p>
        </div>
      </Link>
    </div>
  );
}

export default Requests;