
/*
 Copyright (C) 2000, 2001, 2002, 2003 RiskMap srl
 Copyright (C) 2003, 2004, 2005, 2006, 2007, 2008 StatPro Italia srl
 Copyright (C) 2005 Johan Witters
 Copyright (C) 2013 Simon Shakeshaft
 Copyright (C) 2014 Bitquant Research Laboratories (Asia) Ltd.
 Copyright (C) 2015 Klaus Spanderen
 Copyright (C) 2018 Matthias Lungwitz
 Copyright (C) 2021 Ralf Konrad Eckel

 This file is part of QuantLib, a free-software/open-source library
 for financial quantitative analysts and developers - http://quantlib.org/

 QuantLib is free software: you can redistribute it and/or modify it
 under the terms of the QuantLib license.  You should have received a
 copy of the license along with this program; if not, please email
 <quantlib-dev@lists.sf.net>. The license is also available online at
 <http://quantlib.org/license.shtml>.

 This program is distributed in the hope that it will be useful, but WITHOUT
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 FOR A PARTICULAR PURPOSE.  See the license for more details.
*/

#ifndef quantlib_date_i
#define quantlib_date_i

%include common.i
%include types.i
%include stl.i

%define QL_TYPECHECK_PERIOD                      5220    %enddef

%{
#ifndef QL_HIGH_RESOLUTION_DATE
    // They are not defined in the library, so we define them here
    namespace QuantLib {
        typedef int Hour;
        typedef int Minute;
        typedef int Second;
        typedef int Millisecond;
        typedef int Microsecond;
    }
#endif

using QuantLib::Day;
using QuantLib::Year;
using QuantLib::Hour;
using QuantLib::Minute;
using QuantLib::Second;
using QuantLib::Millisecond;
using QuantLib::Microsecond;
%}

typedef Integer Day;
typedef Integer Year;
// not really their type, but Integer is convertible
// to it and SWIG knows about it.
typedef Integer Hour;
typedef Integer Minute;
typedef Integer Second;
typedef Integer Millisecond;
typedef Integer Microsecond;

#if defined(SWIGJAVA)
%javaconst(1);
#endif

%{
using QuantLib::Weekday;
using QuantLib::Sunday;
using QuantLib::Monday;
using QuantLib::Tuesday;
using QuantLib::Wednesday;
using QuantLib::Thursday;
using QuantLib::Friday;
using QuantLib::Saturday;
%}

enum Weekday {
    Sunday    = 1,
    Monday    = 2,
    Tuesday   = 3,
    Wednesday = 4,
    Thursday  = 5,
    Friday    = 6,
    Saturday  = 7
};


%{
using QuantLib::Month;
using QuantLib::January;
using QuantLib::February;
using QuantLib::March;
using QuantLib::April;
using QuantLib::May;
using QuantLib::June;
using QuantLib::July;
using QuantLib::August;
using QuantLib::September;
using QuantLib::October;
using QuantLib::November;
using QuantLib::December;
%}

enum Month {
    January   = 1,
    February  = 2,
    March     = 3,
    April     = 4,
    May       = 5,
    June      = 6,
    July      = 7,
    August    = 8,
    September = 9,
    October   = 10,
    November  = 11,
    December  = 12
};

%{
using QuantLib::TimeUnit;
using QuantLib::Days;
using QuantLib::Weeks;
using QuantLib::Months;
using QuantLib::Years;
using QuantLib::Hours;
using QuantLib::Minutes;
using QuantLib::Seconds;
using QuantLib::Milliseconds;
using QuantLib::Microseconds;
%}

enum TimeUnit { Days, Weeks, Months, Years, Hours, Minutes, Seconds, 
                Milliseconds,  Microseconds};

%{
using QuantLib::Frequency;
using QuantLib::NoFrequency;
using QuantLib::Once;
using QuantLib::Annual;
using QuantLib::Semiannual;
using QuantLib::EveryFourthMonth;
using QuantLib::Quarterly;
using QuantLib::Bimonthly;
using QuantLib::Monthly;
using QuantLib::EveryFourthWeek;
using QuantLib::Biweekly;
using QuantLib::Weekly;
using QuantLib::Daily;
using QuantLib::OtherFrequency;
%}

enum Frequency {
    NoFrequency = -1,
    Once = 0,
    Annual = 1,
    Semiannual = 2,
    EveryFourthMonth = 3,
    Quarterly = 4,
    Bimonthly = 6,
    Monthly = 12,
    EveryFourthWeek = 13,
    Biweekly = 26,
    Weekly = 52,
    Daily = 365,
    OtherFrequency = 999
};

#if defined(SWIGJAVA)
%javaconst(0);
#endif

// time period

#if defined(SWIGCSHARP)
%typemap(csinterfaces) Period "global::System.IDisposable, global::System.IEquatable<Period>, global::System.IComparable, global::System.IComparable<Period>";
%typemap(cscode) Period %{
  public override string ToString() {
    return this.__str__();
  }

  public override int GetHashCode() {
    return ToString().GetHashCode();
  }

  public int CompareTo(object obj) {
    if (obj != null && !(obj is Period))
      throw new global::System.ArgumentException("Object must be of type Period.");

    return CompareTo(obj as Period);
  }

  public int CompareTo(Period other) {
    // All instances are greater than null
    if (object.ReferenceEquals(other, null))
      return 1;
    else
      return Period.compareTo(this, other);
  }

  public override bool Equals(object obj) {
    return (obj != null) && (obj is Period) && Equals(obj as Period);
  }

  public bool Equals(Period other) {
    return (this == other);
  }

  public static bool operator==(Period lhs, Period rhs) {
    var lhsObject = (object)lhs;
    var rhsObject = (object)rhs;

    // null == null
    if (lhsObject == null && rhsObject == null)
      return true;

    // null != (!null)
    if (lhsObject == null || rhsObject == null)
      return false;

    return lhs.CompareTo(rhs) == 0;
  }

  public static bool operator!=(Period lhs, Period rhs) {
    return !(lhs == rhs);
  }

  public static bool operator<(Period lhs, Period rhs) {
    var lhsObject = (object)lhs;
    var rhsObject = (object)rhs;

    // null == null, therefore (null < null) == false
    if (lhsObject == null && rhsObject == null)
      return false;

    // All instances are greater than null
    if (lhsObject == null)
      return true;

    return lhs.CompareTo(rhs) < 0;
  }

  public static bool operator<=(Period lhs, Period rhs) {
    return (lhs < rhs) || (lhs == rhs);
  }

  public static bool operator>(Period lhs, Period rhs) {
    return !(lhs <= rhs);
  }

  public static bool operator>=(Period lhs, Period rhs) {
    return !(lhs < rhs);
  }
%}
#endif


%{
using QuantLib::Period;
using QuantLib::PeriodParser;
%}

class Period {
    #if defined(SWIGJAVA)
    %rename("repr")           __repr__;
    %rename("compare")        __cmp__;
    #endif
  public:
    Period();
    Period(Integer n, TimeUnit units);
    explicit Period(Frequency);
    Integer length() const;
    TimeUnit units() const;
    Frequency frequency() const;
    %extend {
        Period(const std::string& str) {
            return new Period(PeriodParser::parse(str));
        }
        std::string __str__() {
            std::ostringstream out;
            out << *self;
            return out.str();
        }
        std::string __repr__() {
            std::ostringstream out;
            out << "Period(\"" << QuantLib::io::short_period(*self) << "\")";
            return out.str();
        }
        #if defined(SWIGPYTHON) || defined(SWIGR)
        Period __neg__() {
            return -(*self);
        }
        Period __add__(const Period& p) {
            return *self + p;
        }
        Period __sub__(const Period& p) {
            return *self - p;
        }
        Period __mul__(Integer n) {
            return *self * n;
        }
        #if defined(SWIGPYTHON)
        Period __rmul__(Integer n) {
            return *self * n;
        }
        bool __lt__(const Period& other) {
            return *self < other;
        }
        bool __gt__(const Period& other) {
            return other < *self;
        }
        bool __le__(const Period& other) {
            return !(other < *self);
        }
        bool __ge__(const Period& other) {
            return !(*self < other);
        }
        #endif
        bool __eq__(const Period& other) {
            return *self == other;
        }
        int __cmp__(const Period& other) {
            return *self < other  ? -1 :
                   *self == other ?  0 :
                                     1;
        }
        #endif

        #if defined(SWIGCSHARP)
        static int compareTo(const Period& lhs, const Period& rhs) {
            return lhs < rhs  ? -1 :
                   lhs == rhs ?  0 :
                                 1;
        }
        #endif
    }
    #if defined(SWIGPYTHON)
    %pythoncode %{
    def __hash__(self):
        return hash(str(self))
    %}
    #endif
};

#if defined(SWIGPYTHON)
%typemap(in) boost::optional<Period> %{
    if($input == Py_None)
        $1 = boost::none;
    else
    {
        Period *temp;
        if (!SWIG_IsOK(SWIG_ConvertPtr($input,(void **) &temp, $descriptor(Period*),0)))
            SWIG_exception_fail(SWIG_TypeError, "in method '$symname', expecting type Period");
        $1 = (boost::optional<Period>) *temp;
    }
%}
%typecheck (QL_TYPECHECK_PERIOD) boost::optional<Period> {
    if($input == Py_None)
        $1 = 1;
    else {
        Period *temp;
        int res = SWIG_ConvertPtr($input,(void **) &temp, $descriptor(Period*),0);
        $1 = SWIG_IsOK(res) ? 1 : 0;
    }

}
#endif

namespace std {
    %template(PeriodVector) vector<Period>;
}



%{
using QuantLib::Date;
using QuantLib::DateParser;
%}

#if defined(SWIGPYTHON)
%pythoncode %{
import datetime as _datetime
%}
#endif

#if defined(SWIGR)
%rename(__add__) Date::operator+;
%rename(__sub__) Date::operator-;
%Rruntime %{
setAs("_p_Date", "character",
function(from) {from$ISO()})

setAs("character", "_p_Date",
function(from) { DateParser_parseISO(from) })
setMethod("+", c("_p_Date", "numeric"),
    function(e1,e2) Date___add__(e1,e2))
setMethod("-", c("_p_Date", "numeric"),
    function(e1,e2) Date___sub__(e1,e2))
setMethod("+", c("_p_Date", "_p_Period"),
    function(e1,e2) Date___add__(e1,e2))
setMethod("-", c("_p_Date", "_p_Period"),
    function(e1,e2) Date___sub__(e1,e2))

setMethod("as.numeric", "_p_Date",
    function(x) x$serialNumber())

setAs("character", "_p_Period",
function(from) {Period(from)})
%}
#endif

#if defined(SWIGCSHARP)
%typemap(csinterfaces) Date "global::System.IDisposable, global::System.IComparable";
%typemap(cscode) Date %{
    public static Date operator+(Date d, int i) {
        return d.Add(i);
    }
    public static Date operator-(Date d, int i) {
        return d.Subtract(i);
    }
    public static Date operator+(Date d, Period p) {
        return d.Add(p);
    }
    public static Date operator-(Date d, Period p) {
        return d.Subtract(p);
    }
    public static bool operator==(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null && o2 == null)
            return true;
        if (o1 == null || o2 == null)
            return false;
        return d1.serialNumber() == d2.serialNumber();
    }
    public static bool operator!=(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null && o2 == null)
            return false;
        if (o1 == null || o2 == null)
            return true;
        return d1.serialNumber() != d2.serialNumber();
    }
    public static bool operator>(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null || o2 == null)
            return false;
        return d1.serialNumber() > d2.serialNumber();
    }
    public static bool operator>=(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null || o2 == null)
            return false;
        return d1.serialNumber() >= d2.serialNumber();
    }
    public static bool operator<(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null || o2 == null)
            return false;
        return d1.serialNumber() < d2.serialNumber();
    }
    public static bool operator<=(Date d1, Date d2) {
        object o1 = (object)d1;
        object o2 = (object)d2;
        if (o1 == null || o2 == null)
            return false;
        return d1.serialNumber() <= d2.serialNumber();
    }
    public override bool Equals(object o)
    {
        try
        {
            Date d = (Date)o;
            return this.serialNumber() == d.serialNumber();
        }
        catch
        {
           return false;
        }
    }
    public override string ToString()
    {
        return this.__str__();
    }
    public int CompareTo(object obj) {
        if (obj == null) return 1;

        Date other = obj as Date;
        if (other != null)
            return this.serialNumber().CompareTo(other.serialNumber());
        else
           throw new global::System.ArgumentException("Object is not a Date");
    }
   public override int GetHashCode()
   {
       return this.serialNumber();
   }
%}
#endif

%{
    // used in Date(string, string) defined below
    void _replace_format(std::string& s, const std::string& old_format,
                         const std::string& new_format) {
        std::string::size_type i = s.find(old_format);
        if (i != std::string::npos)
            s.replace(i, old_format.length(), new_format);
    }
%}

class Date {
  public:
    Date();
    Date(Day d, Month m, Year y);
    %extend {
        Date(Day d, Month m, Year y,
             Hour hours, Minute minutes, Second seconds,
             Millisecond millisec = 0, Microsecond microsec = 0) {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return new Date(d, m, y, hours, minutes, seconds,
                            millisec, microsec);
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
    }
    Date(BigInteger serialNumber);
    // access functions
    Weekday weekday() const;
    Day dayOfMonth() const;
    Day dayOfYear() const;        // one-based
    Month month() const;
    Year year() const;
    %extend {
        Hour hours() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->hours();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        Minute minutes() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->minutes();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        Second seconds() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->seconds();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        Millisecond milliseconds() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->milliseconds();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        Microsecond microseconds() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->microseconds();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }

        Time fractionOfDay() const {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->fractionOfDay();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        Time fractionOfSecond() const {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return self->fractionOfSecond();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
    }
    
    BigInteger serialNumber() const;
    // static methods
    static bool isLeap(Year y);
    static Date minDate();
    static Date maxDate();
    static Date todaysDate();
    %extend {
        static Date localDateTime() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return Date::localDateTime();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
        }
        static Date universalDateTime() {
        %#ifdef QL_HIGH_RESOLUTION_DATE
            return Date::universalDateTime();
        %#else
            throw std::runtime_error("QuantLib was not compiled "
                                     "with intraday support");
        %#endif
         }
    }
    static Date endOfMonth(const Date&);
    static bool isEndOfMonth(const Date&);
    static Date nextWeekday(const Date&, Weekday);
    static Date nthWeekday(Size n, Weekday, Month m, Year y);
    #if defined(SWIGPYTHON) || defined(SWIGJAVA) || defined(SWIGR) || defined(SWIGCSHARP)
    Date operator+(BigInteger days) const;
    Date operator-(BigInteger days) const;
    Date operator+(const Period&) const;
    Date operator-(const Period&) const;
    #endif
    %extend {
        Date(const std::string& str, std::string fmt) {
            // convert our old format into the corresponding Boost one
            _replace_format(fmt, "YYYY", "%Y");
            _replace_format(fmt, "yyyy", "%Y");
            _replace_format(fmt, "YY", "%y");
            _replace_format(fmt, "yy", "%y");
            _replace_format(fmt, "MM", "%m");
            _replace_format(fmt, "mm", "%m");
            _replace_format(fmt, "DD", "%d");
            _replace_format(fmt, "dd", "%d");
            return new Date(DateParser::parseFormatted(str,fmt));
        }
        Integer weekdayNumber() {
            return int(self->weekday());
        }
        std::string __str__() {
            std::ostringstream out;
        %#ifdef QL_HIGH_RESOLUTION_DATE
            out << QuantLib::io::iso_datetime(*self);
        %#else
            out << *self;
        %#endif
            return out.str();
        }
        std::string __repr__() {
            std::ostringstream out;
            if (*self == Date())
                out << "Date()";
            else
        %#ifdef QL_HIGH_RESOLUTION_DATE
                out << "Date(" << self->dayOfMonth() << ","
                    << int(self->month()) << "," << self->year() << ","
                    << self->hours() << "," << self->minutes() << ","
                    << self->seconds() << "," << self->milliseconds() << ","
                    << self->microseconds() << ")";
        %#else
                out << "Date(" << self->dayOfMonth() << ","
                    << int(self->month()) << "," << self->year() << ")";
        %#endif
            return out.str();
        }
        std::string ISO() {
            std::ostringstream out;
            out << QuantLib::io::iso_date(*self);
            return out.str();
        }
        #if defined(SWIGPYTHON) || defined(SWIGR)
        BigInteger operator-(const Date& other) {
            return *self - other;
        }
        bool __eq__(const Date& other) {
            return *self == other;
        }
        int __cmp__(const Date& other) {
            if (*self < other)
                return -1;
            else if (*self == other)
                return 0;
            else
                return 1;
        }
        #endif
        #if defined(SWIGPYTHON)
        bool __nonzero__() {
            return (*self != Date());
        }
        bool __bool__() {
            return (*self != Date());
        }
        int __hash__() {
            return self->serialNumber();
        }
        bool __lt__(const Date& other) {
            return *self < other;
        }
        bool __gt__(const Date& other) {
            return other < *self;
        }
        bool __le__(const Date& other) {
            return !(other < *self);
        }
        bool __ge__(const Date& other) {
            return !(*self < other);
        }
        bool __ne__(const Date& other) {
            return *self != other;
        }
        #endif
    }
    #if defined(SWIGPYTHON)
    %pythoncode %{
    def to_date(self):
        return _datetime.date(self.year(), self.month(), self.dayOfMonth())

    @staticmethod
    def from_date(date):
        return Date(date.day, date.month, date.year)
    %}
    #endif
};

class DateParser {
  public:
    static Date parseFormatted(const std::string& str, const std::string& fmt);
    static Date parseISO(const std::string& str);
    %extend {
        static Date parse(const std::string& str, std::string fmt) {
            // convert our old format into the corresponding Boost one
            _replace_format(fmt, "YYYY", "%Y");
            _replace_format(fmt, "yyyy", "%Y");
            _replace_format(fmt, "YY", "%y");
            _replace_format(fmt, "yy", "%y");
            _replace_format(fmt, "MM", "%m");
            _replace_format(fmt, "mm", "%m");
            _replace_format(fmt, "DD", "%d");
            _replace_format(fmt, "dd", "%d");
            return DateParser::parseFormatted(str,fmt);
        }
    }
};

class PeriodParser {
  public:
    static Period parse(const std::string& str);
};


#if defined(SWIGPYTHON)
%pythoncode %{
Date._old___add__ = Date.__add__
Date._old___sub__ = Date.__sub__
def Date_new___add__(self,x):
    if type(x) is tuple and len(x) == 2:
        return self._old___add__(Period(x[0],x[1]))
    else:
        return self._old___add__(x)
def Date_new___sub__(self,x):
    if type(x) is tuple and len(x) == 2:
        return self._old___sub__(Period(x[0],x[1]))
    else:
        return self._old___sub__(x)
Date.__add__ = Date_new___add__
Date.__sub__ = Date_new___sub__
%}
#endif

namespace std {
    %template(DateVector) vector<Date>;
}

Time daysBetween(const Date&, const Date&);

#if defined(SWIGR)


%Rruntime %{
setAs("_p_std__vectorTDate_std__allocatorTDate_t_t",
    "character",
function(from) {if (from$size())
sapply(1:from$size(), function(y) from$"__getitem__"(i=y-1)$ISO())} )

setAs("character", "_p_std__vectorTDate_std__allocatorTDate_t_t",
function(from) { a <- DateVector(length(from));
sapply(1:length(from), function(n) {
a[n] <- from[n] } )
a
})

%}


bool operator==(const Date&, const Date&);
bool operator!=(const Date&, const Date&);
bool operator<(const Date&, const Date&);
bool operator<=(const Date&, const Date&);
bool operator>(const Date&, const Date&);
bool operator>=(const Date&, const Date&);

#endif

%{
using QuantLib::IMM;
%}

struct IMM {
    enum Month { F =  1, G =  2, H =  3,
                 J =  4, K =  5, M =  6,
                 N =  7, Q =  8, U =  9,
                 V = 10, X = 11, Z = 12 };

    static bool isIMMdate(const Date& d,
                          bool mainCycle = true);
    static bool isIMMcode(const std::string& code,
                          bool mainCycle = true);
    static std::string code(const Date& immDate);
    static Date date(const std::string& immCode,
                     const Date& referenceDate = Date());
    static Date nextDate(const Date& d = Date(),
                         bool mainCycle = true);
    static Date nextDate(const std::string& immCode,
                         bool mainCycle = true,
                         const Date& referenceDate = Date());
    static std::string nextCode(const Date& d = Date(),
                                bool mainCycle = true);
    static std::string nextCode(const std::string& immCode,
                                bool mainCycle = true,
                                const Date& referenceDate = Date());
};

%{
using QuantLib::ASX;
%}

struct ASX {
    enum Month { F =  1, G =  2, H =  3,
                 J =  4, K =  5, M =  6,
                 N =  7, Q =  8, U =  9,
                 V = 10, X = 11, Z = 12 };

    static bool isASXdate(const Date& d,
                          bool mainCycle = true);
    static bool isASXcode(const std::string& code,
                          bool mainCycle = true);
    static std::string code(const Date& asxDate);
    static Date date(const std::string& asxCode,
                     const Date& referenceDate = Date());
    static Date nextDate(const Date& d = Date(),
                         bool mainCycle = true);
    static Date nextDate(const std::string& asxCode,
                         bool mainCycle = true,
                         const Date& referenceDate = Date());
    static std::string nextCode(const Date& d = Date(),
                                bool mainCycle = true);
    static std::string nextCode(const std::string& asxCode,
                                bool mainCycle = true,
                                const Date& referenceDate = Date());
};

#endif
