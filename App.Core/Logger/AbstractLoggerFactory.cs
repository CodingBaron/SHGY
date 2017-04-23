using System;
using System.IO;

namespace App.Core.Logger
{
    public abstract class AbstractLoggerFactory : ILogFactory
    {
        public virtual ILogger Create(Type type)
        {
            if (type == null)
            {
                throw new ArgumentNullException("type");
            }

            return Create(type.FullName);
        }

        public virtual ILogger Create(Type type, LoggerLevel level)
        {
            if (type == null)
            {
                throw new ArgumentNullException("type");
            }

            return Create(type.FullName, level);
        }

        public abstract ILogger Create(String name);

        public abstract ILogger Create(String name, LoggerLevel level);

        /// <summary>
        ///   Gets the configuration file.
        /// </summary>
        /// <param name = "fileName">i.e. log4net.config</param>
        /// <returns></returns>
        protected static FileInfo GetConfigFile(string fileName)
        {
            FileInfo result;
            if (Path.IsPathRooted(fileName))
            {
                result = new FileInfo(fileName);
            }
            else
            {
                string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
                result = new FileInfo(Path.Combine(baseDirectory, fileName));
            }
            return result;
        }
    }
}
