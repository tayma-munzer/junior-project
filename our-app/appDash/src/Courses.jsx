import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
function Courses() {
  const [courses, setcourses] = useState([]);

  useEffect(() => {
    axios
      .get('http://127.0.0.1:8000/api/admin/get_courses_requests')
      .then(res => {
        console.log(res.data);
        if (Array.isArray(res.data.courses) && res.data.courses.length > 0) {
          setcourses(res.data.courses);
        } else {
          console.error('Invalid API response format');
        }
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  const deleteCourse = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم الرفض";
    axios
      .post(`http://127.0.0.1:8000/api/admin/reject_course/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedCourse = courses.filter(course => course.c_id !== id);
        setcourses(updatedCourse);
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

  const acceptcourse = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم القبول";
    axios
      .post(`http://127.0.0.1:8000/api/admin/accept_course/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedCourse = courses.filter(course => course.c_id !== id);
        setcourses(updatedCourse);
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
      {courses.map(course => (
        <div className="card-services" key={course.c_id}>
          <img className="service-image" src="path/to/c_img.jpg" alt="Course" />
          <div className="card-content">
            <h2 className="service-title">{course.c_name}</h2>
            <p className="service-description">{course.c_desc}</p>
            <div className="service-details">
              <p>{course.c_price}</p>
            </div>
            <div className="button-container">
            <button type="button" onClick={(e) => acceptcourse(e, course.c_id)} className="accept-button">
              قبول
            </button>
            <button type="button" onClick={(e) => deleteCourse(e, course.c_id)} className="delete-button">
              رفض
            </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

export default Courses;