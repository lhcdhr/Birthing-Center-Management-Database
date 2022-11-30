/*
* COMP421 P3
* Haochen Liu
* 260917834
* */
import java.sql.* ;
import java.text.SimpleDateFormat;
import java.util.Scanner;
import java.util.Date;
class GoBabbyApp
{
    // static fields for storing the appointment query and current appointment date
    static PreparedStatement qApp;
    static String date;
    public static int getAppointments( String id, Connection con, Statement statement)throws SQLException{
        // wait for user input
        System.out.print("Please enter the date for appointment list [E] to exit: ");
        Scanner scanner = new Scanner(System.in);
        date = scanner.next();
        // E for exit
        if(date.equals("E")){
            System.out.println("exit here");
            return 1;
        }
        // query to get all appointments associated with this midwife
        String queryAppointment = "SELECT app_time, role, name, QHCid, cid, nth_pregnancy FROM\n" +
                "(SELECT DISTINCT Appointments.app_time, 'B' AS role, Mothers.name, Mothers.QHCid, Couples.cid, Pregnancies.nth_pregnancy FROM\n" +
                "    Appointments JOIN Pregnancies on Appointments.cid = Pregnancies.cid AND Appointments.nth_pregnancy = Pregnancies.nth_pregnancy\n" +
                "    JOIN Couples on Pregnancies.cid = Couples.cid\n" +
                "    JOIN Mothers on Couples.mother_QHCid = Mothers.QHCid\n" +
                "WHERE Pregnancies.backup_practitioner_id = ? AND Appointments.practitioner_id = ? AND app_date = ?\n" +
                "UNION\n" +
                "SELECT DISTINCT Appointments.app_time,'P' AS role, Mothers.name, Mothers.QHCid, Couples.cid, Pregnancies.nth_pregnancy FROM\n" +
                "    Appointments JOIN Pregnancies on Appointments.cid = Pregnancies.cid AND Appointments.nth_pregnancy = Pregnancies.nth_pregnancy\n" +
                "                 JOIN Couples on Pregnancies.cid = Couples.cid\n" +
                "                 JOIN Mothers on Couples.mother_QHCid = Mothers.QHCid\n" +
                "WHERE Pregnancies.practitioner_id = ? AND Appointments.practitioner_id = ? AND app_date = ?)\n" +
                "ORDER BY app_time";
        qApp = con.prepareStatement(queryAppointment);
        qApp.setString(1,id);
        qApp.setString(2,id);
        qApp.setDate(3,java.sql.Date.valueOf(date));
        qApp.setString(4,id);
        qApp.setString(5,id);
        qApp.setDate(6,java.sql.Date.valueOf(date));

        ResultSet appointments = qApp.executeQuery();
        // display the result of the query, show only the required info
        int row = 0;
        while(appointments.next()){
            System.out.print(row+1);
            System.out.print(":   ");
            String app_time = appointments.getString("app_time");
            //app_times[row] = app_time;
            System.out.print(app_time.substring(0,5)+" ");
            String role = appointments.getString("role");
            System.out.print(role+" ");
            String name = appointments.getString("name");
            System.out.print(name+" ");
            String QHCid = appointments.getString("QHCid");
            System.out.print(QHCid+" ");
            System.out.print("\n");
            row++;
        }
        // no appointments found, go back to main and ask again for a date
        if(row<=0){
            System.out.println("No appointments match for this date.");
            return -1;
        }
        return 0;
    }
    public static void main ( String [ ] args ) throws SQLException
    {
        // Unique table names.  Either the user supplies a unique identifier as a command line argument, or the program makes one up.
        String tableName = "";
        int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        if ( args.length > 0 )
            tableName += args [ 0 ] ;
        else
            tableName += "exampletbl";

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "classified";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = null;
        String your_password = null;
        //AS AN ALTERNATIVE, you can just set your password in the shell environment in the Unix (as shown below) and read it from there.
        //$  export SOCSPASSWD=yoursocspasswd
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
            System.err.println("Error!! do not have a password to connect to the database!");
            System.exit(1);
        }
        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
        // indicator for whether midwife information is found
        boolean found = false;
        int app_index = 0;
        // indicator for whether the program is at the step of finding associated appointments
        boolean selectAppointment = false;
        // indicator for whether user want to go back to appointment lists
        boolean backToAppointmentList = false;
        ResultSet appointments;
        String id = "";
        Scanner scanner;
        while(true){
            if(!found){
                // verify Midwife information
                System.out.print("Please enter your practitioner id [E] to exit: ");
                scanner = new Scanner(System.in);
                id = scanner.next();
                if(id.equals("E")){
                    break;
                }
                String queryMidwifeIDs = "SELECT practitioner_id, name FROM Midwives";
                ResultSet ids = statement.executeQuery (queryMidwifeIDs);
                // verify whether such midwife exists
                while(ids.next()){
                    String prac_id = ids.getString("practitioner_id");
                    if(prac_id.equals(id)){
                        found = true;
                        break;
                    }
                }
                if(!found){
                    System.out.println("practitioner id not matched, please verify and enter again");
                    continue;
                }
            }
            int getApp_result = -1;
            // loop until user exit or found appointment record
            if(!selectAppointment) {
                while (getApp_result == -1) {
                    getApp_result = getAppointments(id, con, statement);
                }
                // user enter E,
                if (getApp_result == 1) {
                    System.out.println("user exit program from entering date");
                    break;
                }
                // appointment records found, ask for date
                System.out.println("Enter the appointment number that you would like to work on.");
                System.out.print("        [E] to exit [D] to go back to another date :");
                scanner = new Scanner(System.in);
                String command = scanner.next();
                if (command.equals("E")) {
                    break;
                } else if (command.equals("D")) {
                    selectAppointment=false;
                    continue;
                }
                // user enter the appointment number
                app_index = Integer.parseInt(command);
                selectAppointment = true;
            }
            // display appointment information
            if(backToAppointmentList){
                appointments = qApp.executeQuery();
                int row = 0;
                while(appointments.next()){
                    System.out.print(row+1);
                    System.out.print(":   ");
                    String app_time = appointments.getString("app_time");
                    System.out.print(app_time.substring(0,5)+" ");
                    String role = appointments.getString("role");
                    System.out.print(role+" ");
                    String name = appointments.getString("name");
                    System.out.print(name+" ");
                    String QHCid = appointments.getString("QHCid");
                    System.out.print(QHCid+" ");
                    System.out.print("\n");
                    row++;
                }
                System.out.println("Enter the appointment number that you would like to work on.");
                System.out.print("        [E] to exit [D] to go back to another date :");
                scanner = new Scanner(System.in);
                String command = scanner.next();
                if (command.equals("E")) {
                    break;
                } else if (command.equals("D")) {
                    selectAppointment=false;
                    backToAppointmentList=false;
                    continue;
                }
                // user enter the appointment number
                app_index = Integer.parseInt(command);
            }
            appointments = qApp.executeQuery();
            int count = 1;
            while(count <= app_index){
                appointments.next();
                count++;
            }
            // functionality for appointments
            System.out.print("For ");
            System.out.print(appointments.getString("name")+" ");
            System.out.print(appointments.getString("QHCid"));
            System.out.print("\n");
            System.out.println();
            System.out.print("1. Review notes\n" +
                    "2. Review tests\n" +
                    "3. Add a note\n" +
                    "4. Prescribe a test\n" +
                    "5. Go back to the appointments.\n" +
                    "\nEnter your choice: ");

            scanner = new Scanner(System.in);
            String command = scanner.next();
            if(command.equals("5")){
                backToAppointmentList=true;
                continue;
            }
            // display notes
            if(command.equals("1")){
                String displayNotes = "SELECT Notes.date, Notes.n_time, left(Notes.contents, 50) AS contents FROM Appointments JOIN Notes on\n" +
                        "    Appointments.practitioner_id = Notes.practitioner_id\n" +
                        "        AND Appointments.app_date = Notes.app_date\n" +
                        "        AND Appointments.app_time = Notes.app_time\n" +
                        "    WHERE cid = ? AND NTH_PREGNANCY=? ORDER BY date DESC, n_time DESC";
                PreparedStatement qDisplayNotes = con.prepareStatement(displayNotes);
                qDisplayNotes.setString(1, appointments.getString("cid"));
                qDisplayNotes.setInt(2, appointments.getInt("nth_pregnancy"));
                ResultSet notes = qDisplayNotes.executeQuery();
                while(notes.next()){
                    System.out.print(notes.getDate("date")+" ");
                    System.out.print(notes.getTime("n_time")+"  ");
                    System.out.print(notes.getString("contents")+"\n");
                }
                backToAppointmentList=false;
                continue;
            }
            // display tests
            if(command.equals("2")){
                String displayTests = "SELECT Tests.prescribe_date, Tests.type, left(Tests.result,50) AS result, Tests.testee\n" +
                        "FROM Tests JOIN Pregnancies ON Tests.cid = Pregnancies.cid AND Tests.nth_pregnancy = Pregnancies.nth_pregnancy\n" +
                        "WHERE Pregnancies.cid = ? AND Pregnancies.nth_pregnancy = ? AND Tests.testee = ?\n" +
                        "ORDER BY prescribe_date DESC";
                PreparedStatement qDisplayTests = con.prepareStatement(displayTests);
                qDisplayTests.setString(1, appointments.getString("cid"));
                qDisplayTests.setInt(2, appointments.getInt("nth_pregnancy"));
                qDisplayTests.setString(3, appointments.getString("name"));
                ResultSet tests = qDisplayTests.executeQuery();
                while(tests.next()){
                    System.out.print(tests.getDate("prescribe_date")+ " ");
                    System.out.print("["+tests.getString("type")+ "] ");
                    // show pending for tests without results
                    if(tests.getString("result")==null){
                        System.out.print("PENDING"+ "\n");
                    }
                    else{
                        System.out.print(tests.getString("result")+ "\n");
                    }
                }
                backToAppointmentList=false;
                continue;
            }
            // add a note
            if(command.equals("3")){
                System.out.print("Please type your observation: ");
                scanner = new Scanner(System.in);
                String observation = scanner.nextLine();
                String insertNote = "INSERT INTO Notes (practitioner_id, app_date, app_time, n_time, date, contents) VALUES" +
                        "(?,?,?,?,?,?)";
                PreparedStatement qInsertNode = con.prepareStatement(insertNote);
                qInsertNode.setString(1, id);
                qInsertNode.setDate(2, java.sql.Date.valueOf(date));
                qInsertNode.setTime(3, java.sql.Time.valueOf(appointments.getString("app_time")));
                Date currentTime = new Date();
                SimpleDateFormat formatter_time = new SimpleDateFormat("HH:mm:ss");
                SimpleDateFormat formatter_date = new SimpleDateFormat("yyyy-MM-dd");
                String timeString = formatter_time.format(currentTime);
                String dateString = formatter_date.format(currentTime);
                qInsertNode.setTime(4, java.sql.Time.valueOf(timeString));
                qInsertNode.setDate(5, java.sql.Date.valueOf(dateString));
                qInsertNode.setString(6,observation);
                qInsertNode.executeUpdate();
                backToAppointmentList=false;
                continue;
            }
            // prescribe a test
            if(command.equals("4")){
                System.out.print("Please enter the type of test: ");
                scanner = new Scanner(System.in);
                String testIDs = "SELECT tid FROM Tests ORDER BY tid DESC";
                ResultSet tids = statement.executeQuery(testIDs);
                tids.next();
                String largest_tid = tids.getString("tid");
                int next_tid_int = Integer.parseInt(largest_tid.substring(4))+1;
                String next_tid = "TEST"+String.format("%0"+4+"d",next_tid_int);
                String type = scanner.nextLine();
                String insertTest = "INSERT INTO Tests (tid, type, sample_date, testee, conduct_date, result, practitioner_id, prescribe_date, tech_id, cid, nth_pregnancy) VALUES" +
                        "(?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement qInsertTest = con.prepareStatement(insertTest);
                qInsertTest.setString(1, next_tid);
                qInsertTest.setString(2, type);
                qInsertTest.setString(3,date);
                qInsertTest.setString(4,appointments.getString("name"));
                qInsertTest.setNull(5, Types.DATE);
                qInsertTest.setNull(6, Types.VARCHAR);
                qInsertTest.setString(7, id);
                qInsertTest.setString(8,date);
                qInsertTest.setNull(9,Types.VARCHAR);
                qInsertTest.setString(10, appointments.getString("cid"));
                qInsertTest.setInt(11, appointments.getInt("nth_pregnancy"));
                qInsertTest.executeUpdate();
                // maintaining the insertion of dating ultrasound test as well
                if(type.equals("dating ultrasound")){
                    String insertUltrasound = "INSERT INTO Dating_Ultrasounds (tid) VALUES (?)";
                    PreparedStatement qInsertUltrasound = con.prepareStatement(insertUltrasound);
                    qInsertUltrasound.setString(1,next_tid);
                }
                backToAppointmentList=false;
                continue;
            }
        }
        // Finally but importantly close the statement and connection
        statement.close ( ) ;
        con.close ( ) ;
    }
}
