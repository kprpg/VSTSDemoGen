using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DoWork
{
    public class Work
    {

        public Work() { }

        public int GetInteger()
        {
            return (int) DateTime.Now.Ticks % 100000;
        }

        public long GetLong()
        {
            return DateTime.Now.Ticks / 3;
        }

        public double GetDouble()
        {
            return (double)DateTime.Now.Ticks / 3.1415926;
        }

        public string GetString()
        {
            return DateTime.Today.ToString();
        }

        public DateTime GetDateTime()
        {
            return DateTime.Now.AddDays(-3).AddHours(2).AddMinutes(-344);
        }

        public TimeSpan GetTimeSpan()
        {
            return DateTime.Now - DateTime.Now.AddDays(933);
        }

        public int Take_1_Parameter(int i)
        {
            return i;
        }

        public int Take_2_Parameters(int i, int j)
        {
            return i + j;
        }

        public string Format_1_Parameter(int i)
        {
            return string.Format("Recieved a value: {0}", i);
        }

        public string Format_2_Parameter(int i, int j)
        {
            return string.Format("Recieved values: {0} and {1}", i, j);
        }

        public void WaitForSeconds(int seconds)
        {
            System.Threading.Thread.Sleep(seconds * 1000);
        }

    }
}
