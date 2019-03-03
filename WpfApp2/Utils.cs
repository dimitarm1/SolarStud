using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MySql.Data.MySqlClient;
using System.Data;
using System.Diagnostics;
using System.Timers;

namespace WpfApp2
{
    class solarium
    {
        public string ime;
        public string ip_address;
        public string com_port;
        public Uri kartinka;
        public float cena_broi;
    }
    public partial class MainWindow : Window
    {
        solarium[] solariumi;
        int solariumi_count = 0;
        Timer timer1;
        int attempts = 10;
        private void CheckDatabase()
        {
            connection = Connection("localhost", "admin", "admin");
            // Create a timer with a two second interval.
            timer1 = new System.Timers.Timer(1000);
            // Hook up the Elapsed event for the timer. 
            timer1.Elapsed += OnTimedEvent;
            timer1.AutoReset = true;
            timer1.Enabled = true;
          
        }
        private  void OnTimedEvent(Object source, ElapsedEventArgs e)
        {
           if(attempts > 0)
            {
                attempts--;
                try
                {
                    string commandLine = "SELECT COUNT(*) FROM solariumi";
                    MySqlCommand cmd = new MySqlCommand(commandLine, connection);
                    connection.Open();
                    solariumi_count = Convert.ToInt32(cmd.ExecuteScalar());
                  
                    if (solariumi_count > 0)
                    {
                        string sql = "SELECT * from solariumi";
                        MySqlCommand cmd_read = new MySqlCommand(sql, connection);
                        MySqlDataReader rdr = cmd_read.ExecuteReader();

                        while (rdr.Read())
                        {
                            Array.Resize<solarium>(ref solariumi, solariumi.Length + 1);
                            solarium sol = new solarium();
                            sol.ime = rdr[1].ToString();
                            sol.ip_address = rdr[2].ToString();
                            sol.com_port = rdr[3].ToString();
                            sol.kartinka = new Uri(rdr[4].ToString());
                            solariumi[solariumi.Length] = sol;
                            Console.WriteLine(rdr[0] + " -- " + rdr[1]);
                        }
                        rdr.Close();
                    }
                    connection.CloseAsync();
                }
                catch
                {
                    connection.CloseAsync();
                }
            }
        }
    }
} 
