import React from 'react';
import { ProgressBar } from 'react-bootstrap';
import { RiDeleteBin6Line } from 'react-icons/ri';

const userData = [
  {
    value: '123456',
  },
  {
    value: 'John',
  },
  {
    value: 'Doe',
  },
  {
    value: '30',
  },
  {
    value: 'Lorem ipsum dolor sit amet...',
  },
  {
    value: 'john.doe@example.com',
  },
  {
    value: 'johndoe',
  },
  {
    value: '********',
  },
  {
    value: 'Male',
  },
  {
    value: 'ABC123',
  },
];

function CustomCard() {
  return (
    <div className='custom-card'>
      <RiDeleteBin6Line className='delete-icon' />
      <h3 className='title'>Card Title</h3>
    </div>
  );
}

function Management() {
  const userImageObj = userData.find((data) => data.name === 'صورة المستخدم');
  const userImage = userImageObj ? userImageObj.value : '';

  const servicesUploaded = 30;
  const coursesUploaded = 20;
  const jobsUploaded = 75;

  return (
    <div className='Manegment-page'>
      <div className='card-M'>
        <div className='user-image'>
          <img src={userImage} alt='User' />
        </div>
        <div className='user-details'>
          <h2>تفاصيل المستخدم</h2>
          <div>
            <strong>معرف المستخدم:</strong> {userData[0].value}
          </div>
          <div>
            <strong>الاسم الأول:</strong> {userData[1].value}
          </div>
          <div>
            <strong>اسم العائلة:</strong> {userData[2].value}
          </div>
          <div>
            <strong>العمر:</strong> {userData[3].value}
          </div>
          <div>
            <strong>وصف المستخدم:</strong> {userData[4].value}
          </div>
          <div>
            <strong>البريد الإلكتروني:</strong> {userData[5].value}
          </div>
          <div>
            <strong>اسم المستخدم:</strong> {userData[6].value}
          </div>
          <div>
            <strong>كلمة المرور:</strong> {userData[7].value}
          </div>
          <div>
            <strong>الجنس:</strong> {userData[8].value}
          </div>
          <div>
            <strong>معرف المشروع:</strong> {userData[9].value}
          </div>
        </div>
      </div>
      <div className='progress-bar-container'>
        {/* Services uploaded progress bar */}
        <div className='progress-container1'>
          <h2>الخدمات </h2>
          <ProgressBar
            now={servicesUploaded}
            label={`${servicesUploaded}%`}
            className='progress-bar-services progress-bar-success' // Add progress-bar-success class
          />
        </div>
        {/* Courses uploaded progress bar */}
        <div className='progress-container2'>
          <h2>الدورات </h2>
          <ProgressBar
            now={coursesUploaded}
            label={`${coursesUploaded}%`}
            className='progress-bar-courses progress-bar-success' // Add progress-bar-success class
          />
        </div>
        {/* Jobs uploaded progress bar */}
        <div className='progress-container3'>
          <h2> الوظائف </h2>
          <ProgressBar
            now={jobsUploaded}
            label={`${jobsUploaded}%`}
            className='progress-bar-jobs progress-bar-success' // Add progress-bar-success class
          />
        </div>
      </div>
      <div className='works'>
        <CustomCard />
      </div>
      {/* Button */}
      <div className='button-container'>
        <button className='custom-button'>حذف الحساب</button>
      </div>
    </div>
   
  );
}

export default Management;