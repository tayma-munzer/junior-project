import React, { useState, useEffect } from 'react';
import { ProgressBar } from 'react-bootstrap';
import { useParams } from 'react-router';
import axios from 'axios';
import { RiDeleteBin6Line } from 'react-icons/ri';

function CustomCard({ title, icon }) {
  return (
    <div className='custom-card'>
      <div className='delete-icon'>{icon}</div>
      <h3 className='title'>{title}</h3>
    </div>
  );
}

function Manegment() {
  const [user, setUser] = useState(null);
  const [jobsUploaded, setJobsUploaded] = useState(0);
  const [servicesUploaded, setservicesUploaded] = useState(0);
  const [coursesUploaded, setcoursesUploaded] = useState(0);
  const [userServices, setUserServices] = useState([]);
  const [userCourses, setUserCourses] = useState([]); // State to store user courses
  const [userJobs, setUserJobs] = useState([]); // State to store user jobs
  const params = useParams();

  useEffect(() => {
    const { u_id } = params;
    axios
      .get(`http://127.0.0.1:8000/api/admin/get_user_profile/${u_id}`)
      .then(res => {
        console.log(res);
        setUser(res.data);
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_jobs_count/${u_id}`)
      .then(res => {
        console.log(res);
        const { jobs_count } = res.data;
        setJobsUploaded(jobs_count);
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_services_count/${u_id}`)
      .then(res => {
        console.log(res);
        const { services_count } = res.data;
        setservicesUploaded(services_count);
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_courses_count/${u_id}`)
      .then(res => {
        console.log(res);
        const { courses_count } = res.data;
        setcoursesUploaded(courses_count);
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_service_user/${u_id}`)
      .then(res => {
        console.log(res);
        setUserServices(res.data);
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_course_user/${u_id}`) // Fetch user courses
      .then(res => {
        console.log(res);
        setUserCourses(res.data); // Save user courses in state
      })
      .catch(error => {
        console.error(error);
      });

    axios
      .get(`http://127.0.0.1:8000/api/admin/get_job_user/${u_id}`) // Fetch user jobs
      .then(res => {
        console.log(res);
        setUserJobs(res.data); // Save user jobs in state
      })
      .catch(error => {
        console.error(error);
      });
  }, [params]);

  if (!user) {
    return <div>Loading...</div>;
  }

  const { u_id, f_name, l_name, age, u_desc, email, username, gender, image } = user;

 const decodedImage = `data:image/jpeg;base64,${image}`; // Add the MIME type to the data URL

console.log(decodedImage); // Log the decoded image data to the console
 
  return (
    <div className='Manegment-page'>
      <div className='card-M'>
        <div className='user-image'>
        
        <img src={decodedImage} alt='User' /> {/* Display the decoded image */}

        </div>
        <div className='user-details'>
          <h2>تفاصيل المستخدم</h2>
          <div>
            <strong>معرف المستخدم:</strong> {u_id}
          </div>
          <div>
            <strong>الاسم الأول:</strong> {f_name}
          </div>
          <div>
            <strong>اسم العائلة:</strong> {l_name}
          </div>
          <div>
            <strong>العمر:</strong> {age}
          </div>
          <div>
            <strong>وصف المستخدم:</strong> {u_desc}
          </div>
          <div>
            <strong>البريد الإلكتروني:</strong> {email}
          </div>
          <div>
            <strong>اسم المستخدم:</strong> {username}
          </div>
          <div>
            <strong>الجنس:</strong> {gender}
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
            className='progress-bar-courses progress-bar-success'// Add progress-bar-success class
          />
        </div>
        {/* Jobs uploaded progress bar */}
        <div className='progress-container3'>
          <h2>الوظائف </h2>
          <ProgressBar
            now={jobsUploaded}
            label={`${jobsUploaded}%`}
            className='progress-bar-jobs progress-bar-success' // Add progress-bar-success class
          />
        </div>
      </div>
      <div className='works'>
        {userServices.map(service => (
          <CustomCard key={service.s_id} title={service.s_name} icon='خدمة' />
        ))}
        {userCourses.map(course => (
          <CustomCard key={course.c_id} title={course.c_name} icon='دورة' />
        ))}
        {userJobs.map(job => (
          <CustomCard key={job.j_id} title={job.j_name} icon='وظيفة' />
        ))}
      </div>
    </div>
  );
}
 
export default Manegment;