import React from 'react';
import {Link} from 'react-router-dom';
function Addcategory() {
  return (
    <div  className="requests-container">
     
      <Link to='/Jobs' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الوظائف</h3>
          <p>إدارة أقسام الوظائف</p>
        </div>
      </Link>
      <Link to='/Courses' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الدورات التعليمية</h3>
          <p>إدارة أقسام الدورات التعليمية</p>
        </div>
      </Link>
      <Link to='/Services' className="request-card" style={{ textDecoration: 'none' }}>
        <div className="request-card-content">
          <h3>الخدمات</h3>
          <p>إدارة أقسام الخدمات</p>
        </div>
      </Link>
     
    </div>
  );
}

export default Addcategory;