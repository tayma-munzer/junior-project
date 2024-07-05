import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { RiDeleteBin6Line } from 'react-icons/ri';

function Complaints() {
  const [complaints, setComplaints] = useState([]);

useEffect(() => {
  axios
    .get('http://127.0.0.1:8000/api/admin/get_complaints')
    .then(res => {
      console.log(res.data);
      if (Array.isArray(res.data.complaints) && res.data.complaints.length > 0) {
        setComplaints(res.data.complaints);
      } else {
        console.error('Invalid API response format');
      }
    })
    .catch(error => {
      console.error(error);
    });
}, []);
 
  /*const complaints = [
    {
      username: 'جون دو',
      title: 'مشكلة في تسجيل الدخول',
      content: 'لا يمكنني تسجيل الدخول إلى حسابي. الرجاء المساعدة!',
    },
    {
      username: 'جين سميث',
      title: 'طلب ميزة جديدة',
      content: 'سيكون رائعًا إذا تمت إضافة خيار الوضع الداكن.',
    },
    // Add more complaints as needed
  ];*/

  return (
    <div>
      <h1 className='complaints-title'>الشكاوى</h1>
      {complaints.map((complaint, index) => (
        <div key={index} className='complaint-card'>
          
          <h3 className='username'>{complaint.user.f_name
          }</h3>
          <h4 className='title'>{complaint.complainable_type}</h4>
          <p className='content'>{complaint.
description}</p>
          
        </div>
      ))}
    </div>
  );
}

export default Complaints;