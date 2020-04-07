using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace INPSDataAccess
{
    public abstract class BaseDAO
    {
        public string ConnectionString
        {
            get
            {
                return @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=INPS;Integrated Security=True";
            }
        }

        protected string ExecuteProcedureJSON(string queryText, CommandType queryType, SqlParameter[] parameters, int commandTimeout = 600)
        {
            string result = string.Empty;            
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();
                using (SqlCommand sqlCommand = new SqlCommand(queryText, conn))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddRange(parameters);
                    SqlDataReader reader = sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        result = reader[0].ToString();
                    }
                }
            }
            return result;
        }
    }
}
