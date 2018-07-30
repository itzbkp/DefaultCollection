using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

namespace DeltaXPOC.Controllers
{
    public class HomeController : Controller
    {

        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(FormCollection form, HttpPostedFileBase umPosterfile)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable castsTable = new DataTable();
                    castsTable.Columns.Add("celebrity_id", typeof(int));
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.saveMovieDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = form["umId"];
                    sqlCommand.Parameters.Add("@NAME", SqlDbType.NVarChar).Value = form["umName"];
                    sqlCommand.Parameters.Add("@YEAROFRELEASE", SqlDbType.Int).Value = form["umYear"];
                    sqlCommand.Parameters.Add("@PLOT", SqlDbType.NVarChar).Value = form["umPlot"];

                    if (umPosterfile != null)
                    {
                        sqlCommand.Parameters.Add("@POSTER", SqlDbType.NVarChar).Value = Path.GetFileName(umPosterfile.FileName);
                        if (umPosterfile.ContentLength > 0)
                            umPosterfile.SaveAs(Path.Combine(Server.MapPath("~/Posters"), Path.GetFileName(umPosterfile.FileName)));
                    }
                    else
                        sqlCommand.Parameters.Add("@POSTER", SqlDbType.NVarChar).Value = form["prevImgName"];

                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    sqlCommand.Parameters.Add("@IDS", SqlDbType.Structured).TypeName = "dbo.CelebrityIDs";
                    sqlCommand.Parameters["@IDS"].Value = castsTable;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    ViewBag.rows = rows[0].Count;
                    return View();
                }
            }
            catch (Exception ex)
            {
                return View();
                ViewBag.ErrorToastr = "<script>toastr.error(" + ex.Message + ");</script>";
            }
        }

        private List<Dictionary<string, object>> convertToDictionary(DataTable dataTable)
        {
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            foreach (DataRow dr in dataTable.Rows)
            {
                Dictionary<string, object> row = new Dictionary<string, object>();
                foreach (DataColumn column in dataTable.Columns)
                {
                    row.Add(column.ColumnName, dr[column]);
                }
                rows.Add(row);
            }
            return rows;
        }

        public JsonResult GetCelebrities()
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.getCelebritiesList", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult CelebrityDetails(int id)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.showCelebrityDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult SaveCelebrity(int id, string name, int role, bool sex, string date_Of_Birth, string bio)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.saveCelebrityDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id;
                    sqlCommand.Parameters.Add("@NAME", SqlDbType.NVarChar).Value = name;
                    sqlCommand.Parameters.Add("@SEX", SqlDbType.Bit).Value = sex;
                    sqlCommand.Parameters.Add("@DATE_OF_BIRTH", SqlDbType.NVarChar).Value = date_Of_Birth;
                    sqlCommand.Parameters.Add("@BIO", SqlDbType.NVarChar).Value = bio;
                    sqlCommand.Parameters.Add("@ROLE", SqlDbType.Int).Value = role;
                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult AddCelebrity(string name, int role)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.saveCelebrityDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = DBNull.Value;
                    sqlCommand.Parameters.Add("@NAME", SqlDbType.NVarChar).Value = name;
                    sqlCommand.Parameters.Add("@SEX", SqlDbType.Bit).Value = DBNull.Value;
                    sqlCommand.Parameters.Add("@DATE_OF_BIRTH", SqlDbType.NVarChar).Value = DBNull.Value;
                    sqlCommand.Parameters.Add("@BIO", SqlDbType.NVarChar).Value = DBNull.Value;
                    sqlCommand.Parameters.Add("@ROLE", SqlDbType.Int).Value = role;
                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult DeleteCelebrity(int id)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.deleteCelebrityDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id;
                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult GetMovies()
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.loadMovieNames", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult GetActors()
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.getActorsList", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult GetProducers()
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.getProducersList", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult MovieDetails(int id)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataSet dataSet = new DataSet();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.showMovieDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataSet);
                    List<Dictionary<string, object>> rows1 = convertToDictionary(dataSet.Tables[0]);
                    List<Dictionary<string, object>> rows2 = convertToDictionary(dataSet.Tables[1]);
                    return Json(new { rows1, rows2 });
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult SaveMovie(int id, string name, string poster, int year, string plot, string actors, string producer)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable castsTable = new DataTable();
                    castsTable.Columns.Add("celebrity_id", typeof(int));
                    string[] actorsarray = actors.Replace("\"", "").Replace("[", "").Replace("]", "").Split(',');
                    List<string> casts = actorsarray.ToList();
                    casts.Add(producer);
                    casts = casts.Where(s => !string.IsNullOrWhiteSpace(s)).Distinct().ToList();
                    foreach (string item in casts)
                    {
                        DataRow dataRow = castsTable.NewRow();
                        dataRow["celebrity_id"] = item;
                        castsTable.Rows.Add(dataRow);
                    }

                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.saveMovieDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id != 0 ? id : System.Data.SqlTypes.SqlInt32.Null;
                    sqlCommand.Parameters.Add("@NAME", SqlDbType.NVarChar).Value = name;
                    sqlCommand.Parameters.Add("@YEAROFRELEASE", SqlDbType.Int).Value = year;
                    sqlCommand.Parameters.Add("@PLOT", SqlDbType.NVarChar).Value = plot;

                    sqlCommand.Parameters.Add("@POSTER", SqlDbType.NVarChar).Value = poster;

                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    sqlCommand.Parameters.Add("@IDS", SqlDbType.Structured).TypeName = "dbo.CelebrityIDs";
                    sqlCommand.Parameters["@IDS"].Value = castsTable;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult DeleteMovie(int id)
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.deleteMovieDetails", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@RECORD_ID", SqlDbType.Int).Value = id;
                    sqlCommand.Parameters.Add("@USER", SqlDbType.NVarChar).Value = Request.UserHostAddress;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

        public JsonResult AllMovies()
        {
            try
            {
                using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["IMDBConnection"].ConnectionString))
                {
                    DataTable dataTable = new DataTable();
                    SqlDataAdapter dataAdapter = new SqlDataAdapter();
                    SqlCommand sqlCommand = new SqlCommand("dbo.getMoviesList", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    dataAdapter.SelectCommand = sqlCommand;
                    dataAdapter.Fill(dataTable);
                    List<Dictionary<string, object>> rows = convertToDictionary(dataTable);
                    return Json(rows);
                }
            }
            catch (Exception ex)
            {
                return Json(ex.Message);
            }
        }

    }
}
