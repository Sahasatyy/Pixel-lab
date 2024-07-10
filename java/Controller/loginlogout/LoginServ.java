package Controller.loginlogout;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.DataBaseConnection.DataBaseConnection;
import Controller.EncryptPassword.EncDyc;
import Model.User.User;
import Model.User.UserMessage;
import Utils.UserQueryHandler;

@WebServlet("/LoginServ")
public class LoginServ extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServ() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");
        String encryptedPassword = "";

        try {
            encryptedPassword = EncDyc.encryption(password, "my-Secret-Key-hi");
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        try {
            UserQueryHandler userQueryHandler = new UserQueryHandler(DataBaseConnection.connection());
            User user = userQueryHandler.authenticateUser(email, encryptedPassword);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("User", user);
                session.setMaxInactiveInterval(30 * 60);
                Cookie cookie = new Cookie("email", user.getEmailAddress());
                response.addCookie(cookie);

                if (user.getRole().equals("admin")) {
                    session.setAttribute("Email", email);
                    response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
                } else {
                    session.setAttribute("name", user.getFirstName());
                    response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
                }
            } else {
                UserMessage msg = new UserMessage("Invalid Login Please Try again!", "Login Error", "invalid-login");
                HttpSession session = request.getSession();
                session.setAttribute("Message", msg);
                response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}