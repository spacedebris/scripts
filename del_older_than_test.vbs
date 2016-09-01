using System.IO; 

string[] files = Directory.GetFiles(AIDA32_v3.94.2);

foreach (string file in files)
{
   FileInfo fi = new FileInfo(file);
   if (fi.GetCreationTime < DateTime.Now.AddDays(-1))
      fi.Delete();
}