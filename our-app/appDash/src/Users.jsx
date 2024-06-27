import React from 'react';
import { HiDotsVertical} from 'react-icons/hi';
import {Link} from 'react-router-dom';
function Users() {
  const users = [
    {
      u_id: 1,
      f_name: 'John',
      l_name: 'Doe',
      age: 25,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user1.jpg',
      email: 'john.doe@example.com',
      username: 'johndoe',
      password: '********',
      gender: 'Male',
      p_id: 123,
    },
    {
      u_id: 2,
      f_name: 'Jane',
      l_name: 'Smith',
      age: 30,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user2.jpg',
      email: 'jane.smith@example.com',
      username: 'janesmith',
      password: '********',
      gender: 'Female',
      p_id: 456,
    },
    {
      u_id: 3,
      f_name: 'Jane',
      l_name: 'Smith',
      age: 30,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user2.jpg',
      email: 'jane.smith@example.com',
      username: 'janesmith',
      password: '********',
      gender: 'Female',
      p_id: 456,
    },
    {
      u_id: 4,
      f_name: 'Jane',
      l_name: 'Smith',
      age: 30,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user2.jpg',
      email: 'jane.smith@example.com',
      username: 'janesmith',
      password: '********',
      gender: 'Female',
      p_id: 456,
    },
    {
      u_id: 5,
      f_name: 'Jane',
      l_name: 'Smith',
      age: 30,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user2.jpg',
      email: 'jane.smith@example.com',
      username: 'janesmith',
      password: '********',
      gender: 'Female',
      p_id: 456,
    },
    {
      u_id: 6,
      f_name: 'Jane',
      l_name: 'Smith',
      age: 30,
      u_desc: 'Lorem ipsum dolor sit amet',
      u_img: 'user2.jpg',
      email: 'jane.smith@example.com',
      username: 'janesmith',
      password: '********',
      gender: 'Female',
      p_id: 456,
    },
    // Add more user objects with their respective data
  ];

  const [currentPage, setCurrentPage] = React.useState(1);
  const usersPerPage = 3; // Adjust the number of users to display per page

  const totalPages = Math.ceil(users.length / usersPerPage);
  const startIndex = (currentPage - 1) * usersPerPage;
  const endIndex = startIndex + usersPerPage;
  const displayedUsers = users.slice(startIndex, endIndex);

  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  return (
    
      <div className="container">
    <h1>سجل المستخدمين</h1>
   
  
      <table className="user-table">
      <thead>
  <tr>
    <th>معرف المستخدم</th>
    <th>الاسم الأول</th>
    <th>اسم العائلة</th>
    <th>العمر</th>
    <th>وصف المستخدم</th>
    <th>صورة المستخدم</th>
    <th>البريد الإلكتروني</th>
    <th>اسم المستخدم</th>
    <th>كلمة المرور</th>
    <th>الجنس</th>
    <th>معرف المشروع</th>
    <th></th>
  </tr>
</thead>
        <tbody>
          {displayedUsers.map((user) => (
            <tr key={user.u_id}>
              <td>{user.u_id}</td>
              <td>{user.f_name}</td>
              <td>{user.l_name}</td>
              <td>{user.age}</td>
              <td>{user.u_desc}</td>
              <td>{user.u_img}</td>
              <td>{user.email}</td>
              <td>{user.username}</td>
              <td>{user.password}</td>
              <td>{user.gender}</td>
              <td>{user.p_id}</td>
              <td>
                <Link to ='/Manegment'>
                <span className="icon-wrapper">
                  <HiDotsVertical className="edit-icon" />
                </span>
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="pagination">
      
<button
  className={`button button-secondary ${currentPage === 1 ? 'disabled' : ''}`}
  onClick={() => handlePageChange(currentPage - 1)}
  disabled={currentPage === 1}
>
  السابق
</button>

<button
  className={`button button-primary ${currentPage === totalPages ? 'disabled' : ''}`}
  onClick={() => handlePageChange(currentPage + 1)}
  disabled={currentPage === totalPages}
>
  التالي
</button>
      </div>
    </div>
  );
}

export default Users;