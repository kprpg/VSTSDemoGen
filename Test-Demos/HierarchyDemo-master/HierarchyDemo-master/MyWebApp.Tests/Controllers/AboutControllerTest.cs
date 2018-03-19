using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MyWebApp;
using MyWebApp.Controllers;

namespace MyWebApp.Tests.Controllers
{
    [TestClass]
    public class AboutControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void About()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.About() as ViewResult;

            // Assert
            Assert.AreEqual("Your application description page.", result.ViewBag.Message);
        }

        [TestMethod]
        public void Contact()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Contact() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }
        [TestMethod]
        public void Output()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Contact() as ViewResult;
            System.Threading.Thread.Sleep(101);

            throw new System.Exception();

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Method1Test1()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Contact() as ViewResult;
            System.Threading.Thread.Sleep(101);

            // Assert
            Method1HelperTest();
            Assert.Fail();
        }
        [TestMethod]
        public void Method1HelperTest2()
        {
            Assert.Fail();
        }
        [TestMethod]
        public void Method1HelperTest()
        {
            Method1HelperTest2();
            Assert.IsTrue(true);
        }
        [TestMethod]
        public void SlowestTest()
        {
            // Arrange
            HomeController controller = new HomeController();

            // Act
            ViewResult result = controller.Contact() as ViewResult;
            System.Threading.Thread.Sleep(1001);

            // Assert
            Assert.IsNotNull(result);
        }
        [TestMethod]
        [TestCategory("SkipWhenLiveUnitTesting")]
        public void SkipLUTFunctionalTest1()
        {
            Assert.Fail();
        }
        [TestMethod]
        [TestCategory("SkipWhenLiveUnitTesting")]
        public void SkipLUTFunctionalTest2()
        {
            Assert.Fail();
        }
    }
}
