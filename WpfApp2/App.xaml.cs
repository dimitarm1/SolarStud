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
            process = new Process();
            process.StartInfo.FileName = "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin\\mysqld";
            process.StartInfo.WorkingDirectory = "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin";
            process.StartInfo.Arguments = "--defaults-file=\"C:\\ProgramData\\MySQL\\MySQL Server 8.0\\my.ini\"";
            process.Start();
        }
    }
}
