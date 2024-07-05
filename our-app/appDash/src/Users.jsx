import React, { useEffect, useState } from 'react';
import { HiDotsVertical } from 'react-icons/hi';
import { FaTrash } from 'react-icons/fa';
import { Link } from 'react-router-dom';
import axios from 'axios';

function Users() {
  const [users, setUsers] = useState([]);

  useEffect(() => {
    axios.get('http://127.0.0.1:8000/api/admin/get_profiles')
      .then(res => {
        console.log(res);
        if (Array.isArray(res.data)) {
          setUsers(res.data);
        } else {
          console.error('Invalid API response format');
        }
      })
      .catch(error => {
        console.error(error);
      });
  }, []);

  const deleteUser = (e, id) => {
    e.preventDefault();
    const thisClicked = e.currentTarget;
    thisClicked.innerText = "Deleting...";
    axios
      .post(`http://127.0.0.1:8000/api/admin/delete_user/${id}`)
      .then((res) => {
        alert(res.data.message);
        thisClicked.closest("tr").remove();
      })
      .catch(function (error) {
        if (error.response) {
          if (error.response.status === 404) {
            alert(error.response.data.message);
            thisClicked.innerText = "Delete";
          }
          if (error.response.status === 500) {
            alert(error.response.data);
          }
        }
      });
  };

  let UserDetails = "";

  if (users.length > 0) {
    UserDetails = users.map((item, index) => (
      <tr key={index}>
         <td>{item.u_id}</td>
        <td>{item.age}</td>
        <td>{item.email}</td>
        <td>{item.f_name}</td>
        <td>{item.gender}</td>
        <td>{item.l_name}</td>
        <td>{item.p_id}</td>
        <td>{item.u_desc}</td>
        <td>{item.u_img}</td>
        <td>{item.username}</td>
        <td>
          <Link to='/Manegment'>
            <span className="icon-wrapper">
              <HiDotsVertical className="edit-icon" />
            </span>
          </Link>
        </td>
        <td>
        <button type="button" onClick={(e)=>deleteUser(e,item.u_id)} className="btn-delete">
          delete
        </button>
        </td>
      </tr>
    ));
  }

  return (
    <div className="container">
      <h1>سجل المستخدمين</h1>
      <table className="user-table">
        <thead>
          <tr>
          <th>معرف المستخدم</th>
            <th>العمر</th>
            <th>البريد الإلكتروني</th>
            <th>الاسم الأول</th>
            <th>الجنس</th>
            <th>اسم العائلة</th>
            <th>معرف المشروع</th>

            <th>وصف المستخدم</th>

            <th>صورة المستخدم</th>
            <th>اسم المستخدم</th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          {UserDetails}
        </tbody>
      </table>
    </div>
  );
}

export default Users;