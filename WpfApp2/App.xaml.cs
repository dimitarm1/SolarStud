using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;

namespace WpfApp2
{
  
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        Process process;
      
        private void Application_Exit(object sender, ExitEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() =>
            {
                try
                {
                    process.Kill();
                }
                catch
                { }
            }));
            // Perform tasks at application exit
          
        }

        private void Application_LoadCompleted(object sender, System.Windows.Navigation.NavigationEventArgs e)
        {
           
        }

        private void Application_Startup(object sender, StartupEventArgs e)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "bin\\mysqld.exe";
            startInfo.Arguments = "--console --skip-grant-tables";
            process.StartInfo = startInfo;
            process.Start();
        }
    }
}
