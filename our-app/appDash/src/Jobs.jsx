import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
function Jobs() {
  const [jobs, setJobs] = useState([]);

  useEffect(() => {
    axios
      .get('http://127.0.0.1:8000/api/admin/get_jobs_requests')
      .then(res => {
        console.log(res.data);
        if (Array.isArray(res.data.jobs) && res.data.jobs.length > 0) {
          setJobs(res.data.jobs);
        } else {
          console.error('Invalid API response format');
        }
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  const deleteJob = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم الرفض";
    axios
      .post(`http://127.0.0.1:8000/api/admin/reject_job/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedJobs = jobs.filter(job => job.j_id !== id);
        setJobs(updatedJobs);
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

  const acceptjob = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "...يتم القبول";
    axios
      .post(`http://127.0.0.1:8000/api/admin/accept_job/${id}`)
      .then((res) => {
        alert(res.data.message);
        const updatedJobs = jobs.filter(job => job.j_id !== id);
        setJobs(updatedJobs);
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
      {jobs.map(job => (
        <div className="card-services" key={job.j_id}>
          
          <div className="card-content">
            <h2 className="service-title">{job.j_name}</h2>
            <p className="service-description">{job.j_desc}</p>
            <div className="service-details">
              <p>{job.j_sal}</p>
            </div>
            <div className="button-container">
            <button type="button" onClick={(e) => acceptjob(e, job.j_id)} className="accept-button">
              قبول
            </button>
            <button type="button" onClick={(e) => deleteJob(e, job.j_id)} className="delete-button">
              رفض
            </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

export default Jobs;