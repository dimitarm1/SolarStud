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

namespace WpfApp2
{
    /// <summary>
    /// Interaction logic for UserControl1.xaml
    /// </summary>
    public partial class UserControl1 : UserControl
    {
        public UserControl1()
        {
            InitializeComponent();
        }
        #region ImageSource
        public static readonly DependencyProperty ImageSourceProperty =
            DependencyProperty.Register
            (
                "ImageSource",
                typeof(Uri),
                typeof(UserControl1),
                new FrameworkPropertyMetadata(new PropertyChangedCallback(OnImageSourceChanged))
            );

        public Uri ImageSource
        {
            get { return (Uri)GetValue(ImageSourceProperty); }
            set { SetValue(ImageSourceProperty, value); }
        }
        #endregion ImageSource
        #region Text
        public static readonly DependencyProperty TextProperty =
            DependencyProperty.Register
            (
                "Text",
                typeof(string),
                typeof(UserControl1),
                new FrameworkPropertyMetadata(new PropertyChangedCallback(OnTextChanged))
            );

        public string Text
        {
            get { return (string)GetValue(TextProperty); }
            set { SetValue(TextProperty, value); }
        }
        #endregion Text
        private static void OnImageSourceChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
        {
            var myUserControl = sender as UserControl1;
            if (myUserControl != null)
            {
                myUserControl.img1.Source = new BitmapImage((Uri)e.NewValue);
            }
        }
        private static void OnTextChanged(DependencyObject sender, DependencyPropertyChangedEventArgs e)
        {
            var myUserControl = sender as UserControl1;
            if (myUserControl != null)
            {
                myUserControl.txt1.Text = e.NewValue.ToString();
            }
        }
    }
}
