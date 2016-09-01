using System.IO; 

string[] files = Directory.GetFiles(dirName);

foreach (string file in files)
{
   FileInfo fi = new FileInfo(file);
   if (fi.LastAccessTime < DateTime.Now.AddMonths(-3))
      fi.Delete();
}