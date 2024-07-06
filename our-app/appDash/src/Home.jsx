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

  useEffect(() => {
    fetchEnrollmentsData();
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
            <Bar dataKey="courses" fill="#A88BCD" />
            <Bar dataKey="services" fill="#88CFBC" />
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
    </main>
  );
}

export default Home;