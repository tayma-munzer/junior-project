import React, { useEffect, useState } from 'react';
import axios from 'axios';
import {
  BarChart,
  Bar,
  LineChart,
  Line,
  CartesianGrid,
  XAxis,
  YAxis,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts';
import {
  BsFillArchiveFill,
  BsFillGrid3X3GapFill,
  BsPeopleFill,
  BsFillBellFill,
} from 'react-icons/bs';
import { FaPercent, FaMoneyBill } from 'react-icons/fa';
import { Link } from 'react-router-dom';

function Home() {
  const [enrollmentsData, setEnrollmentsData] = useState([]);
  const [approvedData, setApprovedData] = useState([]);
  const [usersData, setUsersData] = useState([]);
  const [pindingData, setPindingData] = useState([]);
  const [usersRolesData, setUsersRolesData] = useState([]);

  useEffect(() => {
    fetchEnrollmentsData();
    fetchApprovedData();
    fetchUsersMonthData();
    fetchPindingsData();
    fetchUsersRoleData();
  }, []);

  const fetchEnrollmentsData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/get_enrollments_last_7_days');
      setEnrollmentsData(response.data);
      console.log(response.data); // Move the line here
    } catch (error) {
      console.error('Error fetching enrollments data:', error);
    }
  };
  const fetchApprovedData = async () => { 
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/get_aprovments_last_7_days');
      setApprovedData(response.data);
      console.log(response.data);
    } catch (error) {
      console.error('Error fetching approved data:', error); 
    }
  };

  const fetchUsersMonthData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/get_users_last_month');
      setUsersData(response.data);
      console.log(response.data);
    } catch (error) {
      console.error('Error fetching users data:', error); 
    }
  };

  const fetchUsersRoleData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/num_of_users_in_roles');
      const formattedData = response.data.map((item) => ({
        role: item.role,
        users: item.user_count,
      }));
      setUsersRolesData(formattedData);
      console.log(formattedData);
    } catch (error) {
      console.error('Error fetching users data:', error);
    }
  };

  const fetchPindingsData = async () => {
    try {
      const response = await axios.get('http://127.0.0.1:8000/api/num_of_pindings');
      setPindingData([response.data]); // Wrap the response data in an array
      console.log(response.data);
    } catch (error) {
      console.error('Error fetching pinding data:', error);
    }
  };


  return (
    <main className="main-container">
      <div className="main-title">
        <h3></h3>
      </div>

      <div className="main-cards">
        <Link
          to="/Requests"
          className="card"
          style={{ textDecoration: 'none' }}
        >
          <div className="card-inner">
            <h3>الطلبات</h3>
            <BsFillArchiveFill className="card_icon" />
          </div>
        </Link>

        <Link
          to="/Users"
          className="card"
          style={{ textDecoration: 'none' }}
        >
          <div className="card-inner">
            <h3>المستخدمين</h3>
            <BsPeopleFill className="card_icon" />
          </div>
        </Link>

        <Link
          to="/Complaints"
          className="card"
          style={{ textDecoration: 'none' }}
        >
          <div className="card-inner">
            <h3 style={{ textDecoration: 'none' }}>الشكاوي</h3>
            <BsFillBellFill className="card_icon" />
          </div>
        </Link>
      </div>

      <div className="charts">
        <ResponsiveContainer width="100%" height="100%">
        <BarChart
  width={500}
  height={300}
  data={approvedData}
  margin={{
    top: 5,
    right: 30,
    left: 20,
    bottom: 5,
  }}
> 
  <CartesianGrid strokeDasharray="3 3" />
  <XAxis dataKey="date" />
  <YAxis />
  <Tooltip />
  <Legend />
  <Bar dataKey="courses" fill="#A88BCD" />
  <Bar dataKey="services" fill="#88CFBC" />
  <Bar dataKey="jobs" fill="#EDBEA4" />
</BarChart>
        </ResponsiveContainer>

        <ResponsiveContainer width="100%" height="100%">
          <LineChart
            width={500}
            height={300}
            data={enrollmentsData}
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="date" />
            <YAxis />
            <Tooltip />
            <Legend />
            <Line
              type="monotone"
              dataKey="courses"
              stroke="#A88BCD"
              activeDot={{ r: 8 }}
            />
            <Line type="monotone" dataKey="services" stroke="#88CFBC" />
          </LineChart>
        </ResponsiveContainer>
      </div>
      <div className="charts">
        

      <ResponsiveContainer width="100%" height="100%">
  <LineChart
    width={500}
    height={300}
    data={usersData}
    margin={{
      top: 5,
      right: 30,
      left: 20,
      bottom: 5,
    }}
  >
    <CartesianGrid strokeDasharray="3 3" />
    <XAxis dataKey="date" />
    <YAxis />
    <Tooltip />
    <Legend />
    <Line
      type="monotone"
      dataKey="users" // Update the data key to "users"
      stroke="#A88BCD"
      activeDot={{ r: 8 }}
    />
  </LineChart>
</ResponsiveContainer>
        <ResponsiveContainer width="100%" height="100%">
        <BarChart
            width={500}
            height={300}
            data={pindingData} // Update the data prop to use pindingData
            margin={{
              top: 5,
              right: 30,
              left: 20,
              bottom: 5,
            }}
          >
  <CartesianGrid strokeDasharray="3 3" />
  <XAxis dataKey="date" />
  <YAxis />
  <Tooltip />
  <Legend />
  <Bar dataKey="courses" fill="#A88BCD" />
  <Bar dataKey="services" fill="#88CFBC" />
  <Bar dataKey="jobs" fill="#EDBEA4" />
</BarChart>
        </ResponsiveContainer>
      </div>
      <div className="charts2">
        

      <ResponsiveContainer width="100%" height="100%">
      <LineChart
        width={500}
        height={300}
        data={usersRolesData}
        margin={{
          top: 5,
          right: 30,
          left: 20,
          bottom: 5,
        }}
      >
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="role" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Line
          type="monotone"
          dataKey="users"
          stroke="#A88BCD"
          activeDot={{ r: 8 }}
        />
      </LineChart>
    </ResponsiveContainer>
        </div>
    </main>
  );
}

export default Home;