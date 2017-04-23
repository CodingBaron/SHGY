using System;

namespace App.Core.Logger
{
    public interface ILogFactory
    {
        /// <summary>
		///   Creates a new logger, getting the logger name from the specified type.
		/// </summary>
		ILogger Create(Type type);

        /// <summary>
        ///   Creates a new logger.
        /// </summary>
        ILogger Create(String name);

        /// <summary>
        ///   Creates a new logger, getting the logger name from the specified type.
        /// </summary>
        ILogger Create(Type type, LoggerLevel level);

        /// <summary>
        ///   Creates a new logger.
        /// </summary>
        ILogger Create(String name, LoggerLevel level);
    }
}
