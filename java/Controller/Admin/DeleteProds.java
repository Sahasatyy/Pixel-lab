package Controller.Admin;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Controller.DataBaseConnection.DataBaseConnection;
import Utils.productQueryHandler;

/**
 * Servlet implementation class RemoveProduct
 */
@WebServlet("/DeleteProds")
public class DeleteProds extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProds() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                productQueryHandler productQueryHandler = new productQueryHandler(DataBaseConnection.connection());
                productQueryHandler.deleteProduct(id);
                HttpSession session = request.getSession();
                session.setAttribute("successMsg", "Product removed successfully");
                response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("errorMsg", "Invalid product ID");
                response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorMsg", "An error occurred while removing the product");
            response.sendRedirect(request.getContextPath() + "/pages/admin.jsp");
        }
    }
}