import React from 'react';
import { RiDeleteBin6Line } from 'react-icons/ri';

function Complaints() {
  const complaints = [
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
  ];

  return (
    <div>
      <h1 className='complaints-title'>الشكاوى</h1>
      {complaints.map((complaint, index) => (
        <div key={index} className='complaint-card'>
          
          <h3 className='username'>{complaint.username}</h3>
          <h4 className='title'>{complaint.title}</h4>
          <p className='content'>{complaint.content}</p>
          <RiDeleteBin6Line className='icon' />
        </div>
      ))}
    </div>
  );
}

export default Complaints;