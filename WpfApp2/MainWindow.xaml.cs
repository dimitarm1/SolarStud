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

namespace WpfApp2
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private MySqlConnection connection;
        private MySqlDataAdapter adapter;
        public MainWindow()
        {
          
            InitializeComponent();
        
            //"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld" --defaults-file="C:\ProgramData\MySQL\MySQL Server 8.0\my.ini"
            //connection = new MySqlConnection("server=localhost;user id=admin;password=ae22fc8f;persistsecurityinfo=True;database=esolarex;allowuservariables=True");
            //connection = new MySqlConnection("server=195.201.243.232;user id=httpssit_admin;password=PaSsWoRd128;persistsecurityinfo=True;database=esolarex;allowuservariables=True");
         
        }

        private void DataGrid_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {

        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            connection = Connection("localhost", "admin", "admin");
            adapter = new MySqlDataAdapter("SELECT * from user", connection);
            connection.Open();
            DataTable dt = new DataTable("user");
            //DataSet ds = new DataSet();
            adapter.Fill(dt);
            //adapter.Fill(dt, "user");
            //DataGrid1.DataContext = ds;
            DataGrid1.ItemsSource = dt.DefaultView;
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Settings settings = new Settings();
            Container.Children.Add(new WPF.MDI.MdiChild { Content = new Settings(), Title = "Настройки" });
        }
    }
}
