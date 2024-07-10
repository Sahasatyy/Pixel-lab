package Controller.ActionsforUser;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import Controller.DataBaseConnection.DataBaseConnection;
import Controller.EncryptPassword.EncDyc;
import Model.User.User;
import Model.User.UserMessage;
import Utils.UserQueryHandler;

@MultipartConfig
@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Register() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter printOut = response.getWriter();
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        String phoneNumber = request.getParameter("Contact");
        String emailAddress = request.getParameter("Email");
        String password = request.getParameter("Password");
        Part profileImagePart = request.getPart("ProfilePicture");
        String profileImageName = profileImagePart.getSubmittedFileName();
        String encryptedPassword = "";

        try {
            encryptedPassword = EncDyc.encryption(password, "my-Secret-Key-hi");
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        User user = new User(firstName, lastName, phoneNumber, emailAddress, encryptedPassword, profileImageName, "customer");
        UserQueryHandler queryHandler;

        try {
            queryHandler = new UserQueryHandler(DataBaseConnection.connection());

            if (queryHandler.checkIfUserExists(user)) {
                HttpSession session = request.getSession();
                UserMessage message = new UserMessage("Email already in use. Please use another email", "Registration Error", "invalid-registration");
                session.setAttribute("Message", message);
                response.sendRedirect(request.getContextPath() + "/pages/register.jsp");
            } else {
                if (queryHandler.registerUser(user)) {
                    // Save the profile image if registration is successful
                    saveProfileImage(profileImagePart, profileImageName);
                    response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
                } else {
                    printOut.println("Registration Failed");
                }
            }
        } catch (ClassNotFoundException | SQLException e2) {
            e2.printStackTrace();
        }
    }

    private void saveProfileImage(Part profileImagePart, String profileImageName) {
        String profileImagePath = "D:\\Ecliplse Workplace\\pixellab\\src\\main\\webapp\\images\\userprofilefolder\\" + profileImageName;

        try {
            FileOutputStream fileOutputStream = new FileOutputStream(profileImagePath);
            InputStream inputStream = profileImagePart.getInputStream();
            byte[] data = new byte[inputStream.available()];
            inputStream.read(data);
            fileOutputStream.write(data);
            fileOutputStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}