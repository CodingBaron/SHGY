using PerpetuumSoft.Knockout;
using System.Web.Mvc;

namespace SHGY.Web.Controllers
{
    public class AccountController : Controller
    {
        [AllowAnonymous]
        public ActionResult SignIn()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }
        public ActionResult AccountLock()
        {
            return View();
        }
    }
}