package Utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Model.User.User;

public class UserQueryHandler {

    private Connection connection;

    public UserQueryHandler(Connection connection) {
        this.connection = connection;
    }

    public boolean checkIfUserExists(User user) throws SQLException {
        String query = "SELECT email FROM users WHERE email = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, user.getEmailAddress());
            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public User authenticateUser(String email, String password) {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, email);
            statement.setString(2, password);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    user = new User();
                    user.setFirstName(resultSet.getString("firstName"));
                    user.setProfileImage(resultSet.getString("profilePicture"));
                    user.setEmailAddress(resultSet.getString("email"));
                    user.setPassword(resultSet.getString("password"));
                    user.setPhoneNumber(resultSet.getString("contact"));
                    user.setRole(resultSet.getString("userRole"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public void updateUserProfile(String profileImage, String firstName, String password, String phoneNumber, String email) throws SQLException {
        String query = "UPDATE users SET profilePicture = ?, firstName = ?, password = ?, contact = ? WHERE email = ?";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, profileImage);
            statement.setString(2, firstName);
            statement.setString(3, password);
            statement.setString(4, phoneNumber);
            statement.setString(5, email);
            statement.executeUpdate();
        }
    }

    public boolean registerUser(User user) {
        boolean success = false;
        String query = "INSERT INTO users (firstName, lastName, contact, email, password, profilePicture, userRole) VALUES (?, ?, ?, ?, ?, ?, 'customer')";
        try (PreparedStatement statement = this.connection.prepareStatement(query)) {
            statement.setString(1, user.getFirstName());
            statement.setString(2, user.getLastName());
            statement.setString(3, user.getPhoneNumber());
            statement.setString(4, user.getEmailAddress());
            statement.setString(5, user.getPassword());
            statement.setString(6, user.getProfileImage());
            statement.executeUpdate();
            success = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }
}